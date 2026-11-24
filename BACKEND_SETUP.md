# .NET backend setup

The database is ready for an ASP.NET Core backend using PostgreSQL and Npgsql.

Recommended packages:

```bash
dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package FluentValidation.AspNetCore
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer
```

Use `ConnectionStrings:Erp` from environment configuration. Keep domain modules aligned with the database schemas: Identity, Party, Catalog, Pricing, Inventory, Procurement, Sales, Returns, Finance, Audit, and Integration. Use EF Core migrations or a controlled deployment tool for future changes; `database/schema.sql` is the initial install artifact.

For inventory, payment allocation, invoice confirmation, and outbox publishing, use explicit Npgsql transactions and `SELECT ... FOR UPDATE` where described in `database/queries/operations.sql`. Do not expose PostgreSQL directly to React. React should call authenticated ASP.NET Core APIs over HTTPS.

For local startup:

```powershell
Copy-Item .env.example .env
docker compose up -d
```

The React application should receive only API DTOs, never database entities or connection strings. Configure its API base URL separately, for example `VITE_API_BASE_URL=https://localhost:7001/api` in the React development configuration.
