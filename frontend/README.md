# AURA ERP — Front-End (Flutter Web)

> **THIS UI IS JUST AN INTIAL ONE THAT WILL BE MODIFIED FOR RAEL DEPLOYMENT LATER AGAIN AFTER THE BACK-END WILL HAVE BEEN FINISHED**

This repository contains the Flutter Web front-end (`erp_system`) for **AURA ERP**, structured around modular feature directories, role-based access control (RBAC), `flutter_screenutil` (`1440x860`), and repository abstractions so the back-end team can run and test the front-end via Docker without installing the Flutter SDK locally.

---

## 1. Current Status & Scope

* **Current Mode:** Running in mock-data mode (`USE_MOCK_DATA=true`) via in-memory mock repositories while back-end microservices, Power BI dashboards, and AI/OCR services are still being built.
* **Target Platform:** Flutter Web on Windows (10/11) modern browsers, designed around a `1440x860` reference resolution using `flutter_screenutil` and `go_router`.
* **Docker Scope:** Currently configured to run the front-end containers standalone first (`frontend-dev` and `frontend-prod`), before merging into a unified Docker Compose setup with PostgreSQL (`database/schema.sql`) and back-end services.
* **Entry Points / Flavors:**
  * `lib/main_dev.dart` (`FLAVOR=dev`) — Development workspace with a **Dev Role Preview** selector in the top bar.
  * `lib/main_admin.dart` (`FLAVOR=admin`) — Administrator portal entry point.
  * `lib/main_employee.dart` (`FLAVOR=employee`) — Staff workspace entry point.

---

## 2. Running the Front-End with Docker (No Flutter SDK Needed)

Ensure **Docker Desktop** is running, then open a terminal (such as Windows PowerShell) inside `frontend/`.

### Step 1: Create Local `.env` File
```powershell
Copy-Item .env.example .env
```
*(In `cmd.exe`: `copy .env.example .env`)*

### Step 2: Run Development Server (`frontend-dev`)
```powershell
docker compose up --build frontend-dev
```
* Open **`http://localhost:8080`** in your browser (avoid opening `0.0.0.0:8080` directly).
* Stop with `Ctrl + C`, then run `docker compose down`.

### Step 3: Run Production Container (`frontend-prod` via Nginx)
```powershell
docker compose up --build frontend-prod
```
* Open **`http://localhost`** (port `80`).
* `nginx/nginx.conf` provides Single-Page Application (SPA) fallback (`try_files $uri $uri/ /index.html`) so `go_router` paths (`/products`, `/sales`, `/analytics/dashboard`, `/users`, etc.) work on browser refresh.
* Stop with `docker compose down`.

---

## 3. Project Folder Structure (`lib/`)

```text
lib/
├── main_dev.dart                      # Dev flavor entry point
├── main_admin.dart                    # Admin flavor entry point
├── main_employee.dart                 # Employee flavor entry point
├── erp_app.dart                       # ScreenUtilInit (1440x860), MultiBlocProvider & MaterialApp.router
├── core/
│   ├── config/
│   │   ├── env_config.dart            # Compile-time --dart-define configuration
│   │   ├── navigation_config.dart     # Sidebar items, roles & RBAC access helpers
│   │   ├── app_router.dart            # GoRouter + ShellRoute + role/flavor route guards
│   │   └── service_locator.dart       # GetIt dependency injection (Mock vs. Remote)
│   ├── error/
│   │   └── failures.dart              # Failure classes (Server, Network, Unauthorized, Validation)
│   ├── network/
│   │   └── api_client.dart            # Dio HTTP client + JWT Bearer & error interceptors
│   ├── theme/
│   │   ├── app_colors.dart            # Brand, neutral, semantic & sidebar color tokens
│   │   ├── app_text_styles.dart       # Shared typography scale & TextTheme
│   │   └── app_theme.dart             # Material theme + AppSemanticColors ThemeExtension
│   └── utils/
│       └── formatters.dart            # Currency & display formatting helpers
├── shared_ui/
│   ├── erp_page_header.dart           # Standard module header & action slot
│   ├── kpi_metric_card.dart           # Summary KPI card component
│   ├── erp_data_table_card.dart       # Search, filter, action & scrollable DataTable card
│   ├── erp_section_card.dart          # Section container card
│   └── status_badge.dart              # Semantic status pill badge
└── features/
    ├── landing/
    │   ├── screens/landing_screen.dart
    │   ├── views/landing_side_bar_view.dart
    │   ├── views/landing_top_bar_view.dart
    │   └── widgets/sidebar_nav_tile.dart
    ├── auth/                          # IAM: Login, Users & Permissions, AuthCubit, Mock & Remote repos
    ├── catalog/                       # Catalog: Products & Catalog, CatalogCubit, Mock & Remote repos
    ├── inventory/                     # Inventory: Stock & Movements, InventoryCubit, Mock & Remote repos
    ├── sales/                         # Sales: Invoices & Customers, SalesCubit, Mock & Remote repos
    ├── procurement/                   # Procurement: Purchases & Suppliers, ProcurementCubit, Mock & Remote repos
    ├── returns/                       # Returns: Customer & supplier returns screen
    ├── finance/                       # Finance: Payments & ledger balances screen
    └── analytics/                     # Analytics: Power BI embed slot, OCR Scanner & AI Assistant screens
```

---

## 4. Integration Guide for the Back-End Team

1. **API Gateway Base URL & Authentication (`lib/core/network/api_client.dart` & `lib/core/config/env_config.dart`):**
   * `EnvConfig.apiBaseUrl` reads `API_BASE_URL` (default `http://localhost:8000/api`).
   * After authenticating with the IAM service, store/pass the JWT token via `apiClient.setAuthToken(token)` so the Dio request interceptor attaches `Authorization: Bearer <token>` on requests.
   * Update the `TODO [BACKEND API / IAM]` interceptor hooks in `api_client.dart` for token refresh and standardized error responses.

2. **Swapping Mock Repositories for Live APIs (`lib/core/config/service_locator.dart`):**
   * Feature data layers separate abstract `Repository` interfaces from `Mock*Repository` and `Remote*Repository` classes.
   * Implement the `TODO [BACKEND API]` methods inside `RemoteAuthRepository`, `RemoteCatalogRepository`, `RemoteInventoryRepository`, `RemoteSalesRepository`, and `RemoteProcurementRepository`, and add `fromJson` / `toJson` methods on feature models.
   * Set `USE_MOCK_DATA=false` (via `.env` or `--dart-define=USE_MOCK_DATA=false`) once live endpoints are ready for integration testing.

3. **Remaining Modules & External Integrations (`TODO` Markers):**
   * **`lib/features/returns/screens/returns_screen.dart` & `lib/features/finance/screens/company_finance_screen.dart`:** Marked with `TODO [BACKEND API]` to connect their Cubits and repositories.
   * **`lib/features/analytics/screens/power_bi_dashboard_screen.dart`:** Marked with `TODO [POWER BI]` to mount the Power BI embed (`POWER_BI_EMBED_URL`) once published.
   * **`lib/features/analytics/screens/ocr_scanner_screen.dart` & `ai_assistant_screen.dart`:** Marked with `TODO [AI / OCR SERVICE]` and `TODO [AI SERVICE]` (`AI_SERVICE_BASE_URL`) for invoice OCR extraction/confirmation and natural-language business queries.

4. **RBAC & Roles (`lib/core/config/navigation_config.dart`):**
   * Roles currently mapped in `UserRole` include `admin`, `manager`, `warehouseEmployee`, `salesEmployee`, `purchasingEmployee`, `accountant`, and `cashier`. Align exact role identifiers and endpoint permissions with the IAM service during backend integration.