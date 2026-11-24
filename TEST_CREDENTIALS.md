# QA Test Credentials

For local QA login testing only. These credentials must not be used in production.

| Role | Email | Plaintext Test Password | Access Scope |
|---|---|---|---|
| Admin | admin@company.local | `AURA-Admin-2026!` | Full system access; user and role administration |
| Inventory | inventory@company.local | `AURA-Inventory-2026!` | Stock, warehouses, and inventory management |
| Data Entry | dataentry@company.local | `AURA-DataEntry-2026!` | Record input, validation, and operational updates |
| Client | client@company.local | `AURA-Client-2026!` | Orders, invoices, and account status |
| Supplier | supplier@company.local | `AURA-Supplier-2026!` | Purchase orders, deliveries, and supply catalog |

The mock authentication store contains only PBKDF2-SHA-256 password hashes and unique salts. Plaintext passwords are not stored or compared. Delete this file before production deployment.
