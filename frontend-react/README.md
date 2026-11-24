# AURA ERP React frontend

React + TypeScript implementation of the AURA ERP web client. The current UI uses development mock data and is ready for API integration through `VITE_API_BASE_URL`.

Run locally with Node 20+:

```powershell
npm install
npm run dev
```

Or from the project root:

```powershell
docker compose up --build -d postgres frontend-dev
```

Open http://localhost:8080. React is now the only frontend implementation in this repository.
