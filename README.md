# AURA ERP — Enterprise Resource Planning System
Enterprise Resource Planning (ERP) System – Graduation Project

> **Note:** The current React front-end UI uses mock data while the back-end services are being completed.

Production-oriented ERP foundation using **PostgreSQL 16**, **ASP.NET Core**, and **React with TypeScript**.

---

## Current Status

### 1. Database (`database/`)
The PostgreSQL database implementation is available as a consolidated script:
- [database/schema.sql](database/schema.sql) — schemas, tables, constraints, views, indexes, and development seed data
- [database/queries/operations.sql](database/queries/operations.sql) — transaction-safe ERP operation templates
- [database/README.md](database/README.md) — architecture, ownership, integrity, security, and deployment guidance
- [BACKEND_SETUP.md](BACKEND_SETUP.md) — .NET/Npgsql and React integration setup

No production business data is included. Seed data is limited to development roles, permissions, catalog basics, warehouse basics, and financial accounts.

### 2. Front-End (`frontend-react/`)
The React + TypeScript client (`AURA ERP`) is containerized and documented in [frontend-react/README.md](frontend-react/README.md).
It currently uses mock data and is structured for API integration through the ASP.NET Core API Gateway.

---

## Run PostgreSQL & React Front-End with Docker

Run all commands from the **project root** (`ERP-System/`) with **Docker Desktop** running:

### Step 1: Configure Environment Variables
```powershell
Copy-Item .env.example .env
```
*(Update `POSTGRES_PASSWORD` and `Jwt__SigningKey` in `.env` before running.)*

### Step 2: Run PostgreSQL + Front-End (Development Mode)
```powershell
docker compose up --build -d postgres frontend-dev
```
* **Front-End Dev URL:** `http://localhost:8080` *(do not open `0.0.0.0:8080` directly in the browser; includes the **Dev Role Preview** switcher in the top bar)*
* **PostgreSQL:** `localhost:5432` (initialized automatically from `database/schema.sql` on first start; connect using `ConnectionStrings__Erp` from `.env`)

### Step 3: Run PostgreSQL + Front-End (Production Nginx Build)
```powershell
docker compose up --build -d postgres frontend-prod
```
* **Front-End Prod URL:** `http://localhost` (port `80`, served via Nginx with SPA fallback for the React/Vite client)
* The React client currently uses development mock data and is structured for API integration through the ASP.NET Core gateway.

### Step 4: Useful Verification & Lifecycle Commands
* **Check running container status:**
  ```powershell
  docker compose ps
  ```
* **Verify initialized PostgreSQL schemas:**
  ```powershell
  docker exec -it erp-postgres psql -U erp_app -d erp -c "\dn"
  ```
* **View container logs:**
  ```powershell
  docker compose logs -f
  ```
* **Stop all services (preserving database volume):**
  ```powershell
  docker compose down
  ```
* **Stop all services and reset the database volume (re-runs `schema.sql`):**
  ```powershell
  docker compose down -v
  ```

---

## Application Architecture

The back-end should use **ASP.NET Core** with **Npgsql** and expose authenticated REST APIs through the API Gateway for the React client. **React must never connect directly to PostgreSQL.**

Back-end modules follow the database schema boundaries:
- `identity` — Users, roles, permissions, and JWT authentication
- `party` — Customers, suppliers, and sales representatives
- `catalog` & `pricing` — Products, categories, brands, units, and effective-dated price lists
- `inventory` — Warehouses, storage locations, batches, stock balances, reservations, and stock movements
- `procurement` & `sales` — Purchase invoices, sales invoices, and line items
- `returns` — Customer/supplier returns and refunds
- `finance` — Cash accounts, payments, allocations, and double-entry journal ledgers
- `audit` & `integration` — Audit logs and transactional outbox events

Inventory sales, reservations, payment allocations, invoice confirmation, accounting entries, and outbox publishing must execute inside PostgreSQL transactions. See [database/README.md](database/README.md) and [database/queries/operations.sql](database/queries/operations.sql) before implementing these workflows.
