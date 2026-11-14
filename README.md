# ERP-System
Enterprise Resource Planning (ERP) System – Graduation Project
# ERP System

Production-oriented ERP foundation using PostgreSQL, ASP.NET Core, and Flutter.

## Current status

The PostgreSQL database implementation is available as one consolidated script:

- [database/schema.sql](database/schema.sql) — schemas, tables, constraints, views, indexes, and development seed data
- [database/queries/operations.sql](database/queries/operations.sql) — transaction-safe ERP operation templates
- [database/README.md](database/README.md) — architecture, ownership, integrity, security, and deployment guidance
- [BACKEND_SETUP.md](BACKEND_SETUP.md) — .NET/Npgsql and Flutter integration setup

No production business data is included. The seed data is limited to development roles, permissions, catalog basics, warehouse basics, and financial accounts. The admin password is intentionally a placeholder.

## Run PostgreSQL locally

Copy the environment template and start PostgreSQL with Docker:

```powershell
Copy-Item .env.example .env
docker compose up -d
```

The database is initialized automatically on the first start. Connect using the `ConnectionStrings__Erp` setting from `.env`.

## Application architecture

The backend should use ASP.NET Core with Npgsql and expose authenticated APIs for the Flutter client. Flutter must not connect directly to PostgreSQL. Backend modules should follow the database boundaries: Identity, Party, Catalog, Pricing, Inventory, Procurement, Sales, Returns, Finance, Audit, and Integration.

Inventory sales, reservations, payment allocations, invoice confirmation, accounting, and outbox publishing must execute in PostgreSQL transactions. See the database documentation before implementing these workflows.
