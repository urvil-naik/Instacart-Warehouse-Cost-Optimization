# Instacart Warehouse Cost Optimization

Optimizing a 32M-row Instacart dataset on Snowflake — turning a slow, expensive flat table into a lean star schema with dbt, cutting query time by 93% and cloud costs by ~90% through clustering, partitioning, and query rewrites.

---

## Tech Stack

- **Warehouse** — Snowflake
- **Storage** — Azure ADLS Gen2
- **Transformation** — dbt Core
- **Modeling** — Star Schema
- **Language** — SQL
- **Ingestion** — Snowflake External Stage + `COPY INTO`
- **Performance** — Clustering Keys, Materialized Views
- **Monitoring** — `SNOWFLAKE.ACCOUNT_USAGE`

---

## Project Structure

```
instacart-warehouse-optimization/
│
├── assets/
│   └── architecture.svg
│
├── setup/
│   ├── 00_setup.sql           # databases, schemas, warehouses
│   ├── 01_stage.sql           # Azure ADLS external stage
│   └── 02_raw_tables.sql      # DDL + COPY INTO
│
├── unoptimized/
│   ├── 03_flat_table.sql      # denormalized baseline
│   ├── q1_reorder_rate.sql
│   ├── q2_user_frequency.sql
│   └── q3_shopping_patterns.sql
│
├── dbt/
│   ├── dbt_project.yml
│   ├── packages.yml
│   └── models/
│       ├── staging/
│       └── marts/core/
│
├── optimized/
│   ├── 06_clustering.sql
│   └── q1_q2_q3_optimized.sql
│
└── monitoring/
    ├── 04_baseline.sql
    └── 08_before_after.sql
```

## Dataset

[Instacart Market Basket Analysis](https://www.kaggle.com/c/instacart-market-basket-analysis) — Kaggle.

| File | Rows |
|---|---|
| orders.csv | 3,421,083 |
| order_products__prior.csv | 32,434,489 |
| order_products__train.csv | 1,384,617 |
| products.csv | 49,688 |
| aisles.csv | 134 |
| departments.csv | 21 |
