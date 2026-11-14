# ERP PostgreSQL database

This is the initial single-PostgreSQL deployment for the ERP. Each schema is a future service boundary: `identity`, `party`, `catalog`, `pricing`, `inventory`, `procurement`, `sales`, `returns`, `finance`, `audit`, and `integration`. PostgreSQL is the only supported engine; all timestamps are UTC `timestamptz` and all amounts/quantities use exact `numeric` types.

## Ownership and relationships

Identity owns users and RBAC. Party owns the single business-entity master and customer/supplier roles. Catalog owns products and units. Pricing owns immutable effective-dated prices. Inventory owns physical stock, reservations, receipts, and the immutable movement ledger. Procurement and sales own their documents and lines. Returns owns return/refund workflow. Finance owns payments, cash, and double-entry journals. Audit owns append-only audit records. Integration owns the transactional outbox.

Foreign keys exist only inside a service boundary. IDs such as `customer_id`, `supplier_id`, `product_id`, `user_id`, invoice references, and outbox aggregate references are intentionally not cross-schema foreign keys. The application/service layer validates them while the database is still co-located. This prevents future database splitting from requiring distributed foreign keys.

## Installing the schema

Install the complete database with `psql "$env:DATABASE_URL" -v ON_ERROR_STOP=1 -f database/schema.sql`. Run it against a new database, review extension privileges with your DBA, and take a backup before reinstallation. For production evolution, use your backend deployment process to introduce separately reviewed versioned changes; this repository intentionally ships the initial database as one consolidated PostgreSQL script.

The seed migration is development data. The admin password is deliberately a placeholder and must be replaced by the identity service with an Argon2id/bcrypt hash before use.

## Integrity and concurrency

The service transaction that sells or reserves stock must lock the relevant `inventory.stock_balances` rows with `SELECT ... FOR UPDATE`, check `quantity_on_hand - quantity_reserved`, update the row, append `stock_movements`, and insert an `integration.outbox_events` record before commit. The `quantity_reserved <= quantity_on_hand` check prevents invalid state; the locking protocol prevents overselling and duplicate reservation under concurrency. Keep stock movements and finalized documents append-oriented; cancel/reverse them rather than deleting them.

Payments are allocated through `finance.payment_allocations`. The payment service must lock the payment row and all target invoice rows, then verify `sum(allocations)+new_amount <= payment.amount` in the same transaction. Journal entries are posted only when their deferred balance check sees equal non-zero debit and credit totals. Customer and supplier balances are derived from documents, allocations, and journals, not editable balance columns.

## Roles and security

Create separate database roles outside the schema script: a deployment owner with DDL rights, an application role with DML only on service schemas and no `CREATE EXTENSION`, and a reporting role with `CONNECT` plus `SELECT` on reporting views only. Revoke `CREATE` on `public`; never place passwords in source control. Prefer service-specific roles after database splitting.

## Backups and splitting

Use encrypted, tested base backups plus WAL archiving and point-in-time recovery. Test restores regularly. When splitting services, move each schema and its owned tables, replace cross-service IDs with API/event validation, and retain the outbox per service. CDC/event consumers should use `integration.outbox_events` with `FOR UPDATE SKIP LOCKED`, publish idempotently, then mark events published.

## Reporting

The reporting section of `database/schema.sql` provides read-only abstractions for stock, low stock, expiring stock, sales/purchases, outstanding invoices, cash, prices, reservations, returns, refunds, and product totals. Customer/supplier statement views are intentionally a foundation; production reporting should union posted invoices, returns, payments, credits, and journal lines according to the accounting policy.
