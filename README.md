# DataOps PoC

A proof of concept demonstrating DataOps practices for the data management team — specifically **version control** and **code review** for operational data activities.

Built with dbt + DuckDB (runs entirely on your laptop, no server needed).

---

## What this repo demonstrates

| Practice | How it's implemented |
|---|---|
| Version control | Every change lives in Git — full history, rollback anytime |
| Branching strategy | `main` is protected — all changes go through a branch + PR |
| Code review | PR template + reviewer checklist on every pull request |
| Automated checks | GitHub Actions runs dbt compile + dbt test on every PR |
| Data quality tests | `not_null`, `unique`, `accepted_values` tests on all models |
| Documentation | Column descriptions in `schema.yml` for every model |

---

## Project structure

```
dataops-poc/
├── .github/
│   ├── workflows/
│   │   └── ci.yml              ← CI pipeline (runs on every PR)
│   ├── CODEOWNERS              ← auto-assigns reviewers
│   └── pull_request_template.md ← PR checklist form
├── models/
│   ├── staging/
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   └── stg_events.sql
│   ├── marts/
│   │   ├── mart_monthly_revenue.sql
│   │   └── mart_customer_summary.sql
│   └── schema.yml              ← tests + docs for all models
├── seeds/
│   ├── customers.csv           ← fake sample data
│   ├── orders.csv
│   └── events.csv
├── dbt_project.yml
├── profiles.yml
└── requirements.txt
```

---

## How to run it locally

**1. Clone the repo**
```bash
git clone https://github.com/bayalagmaaMobi/dataops-poc.git
cd dataops-poc
```

**2. Install dbt**
```bash
pip install dbt-duckdb
```

**3. Run everything**
```bash
dbt seed        # loads the fake CSV data
dbt run         # builds all models
dbt test        # runs all data quality tests
```

All tests should pass. You'll see a `dataops_poc.duckdb` file created locally — that's your local database.

---

## How to make a change (the DataOps way)

**Never push directly to `main`.** Always follow these steps:

```bash
# 1. Create a branch
git checkout -b feature/your-change-name

# 2. Make your changes to models or seeds

# 3. Test locally first
dbt run && dbt test

# 4. Commit with a clear message
git add .
git commit -m "feat: add customer churn model"

# 5. Push and open a PR on GitHub
git push origin feature/your-change-name
```

Then open a Pull Request on GitHub. The CI pipeline runs automatically. Once CI is green and 1 teammate has approved — you can merge.

---

## Branching conventions

| Prefix | Use for |
|---|---|
| `feature/` | New models, new data sources, new reports |
| `fix/` | Bug fixes, data quality corrections |
| `chore/` | Config changes, dependency updates |
| `docs/` | Documentation only changes |
| `hotfix/` | Urgent production fixes |

---

## Data models

### Staging (views)
- `stg_customers` — cleaned customer records
- `stg_orders` — cleaned orders with revenue flag
- `stg_events` — cleaned user activity events

### Marts (tables)
- `mart_monthly_revenue` — revenue rolled up by calendar month
- `mart_customer_summary` — one row per customer with order history

---

## CI pipeline

On every pull request, GitHub Actions automatically:
1. Installs dbt
2. Loads seed data (`dbt seed`)
3. Compiles all SQL (`dbt compile`)
4. Builds all models (`dbt run`)
5. Runs all tests (`dbt test`)

**A PR cannot be merged if CI is failing.**

---

## Team

| Name | GitHub | Role |
|---|---|---|
| Bayalagmaa | @bayalagmaaMobi | Data Engineer |
