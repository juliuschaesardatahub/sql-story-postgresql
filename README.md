# SQL Story PostgreSQL

`sql-story-postgresql` is a hands-on PostgreSQL learning repository for studying SQL from novice to advanced. It uses Docker to start PostgreSQL and pgAdmin, then loads two datasets for real query practice:

- `periode`: a calendar table loaded from `data/period.csv`
- `superstore`: a retail sales table loaded from `data/superstore.csv`

This repo is designed as a learning journey, not just a Docker setup. Start with simple `SELECT` queries, move into grouped analysis, and then work with joins, CTEs, window functions, PostgreSQL-specific features, schema design, transactions, and query tuning.

## Project Structure

```text
sql-story-postgresql/
|-- docker-compose.yml
|-- README.md
|-- data/
|   |-- period.csv
|   `-- superstore.csv
|-- init-db/
|   `-- 01-load-data.sql
|-- exercises/
|   |-- 01-novice-exercises.sql
|   |-- 02-intermediate-exercises.sql
|   |-- 03-advanced-exercises.sql
|   |-- 04-database-objects-exercises.sql
|   |-- 05-ddl-dml-exercises.sql
|   |-- 06-performance-exercises.sql
|   |-- 07-data-types-exercises.sql
|   |-- 08-postgresql-features-exercises.sql
|   |-- 09-joins-exercises.sql
|   |-- 10-subqueries-exercises.sql
|   |-- 11-schema-design-exercises.sql
|   `-- 12-transactions-exercises.sql
|-- lessons/
|   |-- 01-novice.sql
|   |-- 02-intermediate.sql
|   |-- 03-advanced.sql
|   |-- 04-database-objects.sql
|   |-- 05-ddl-dml.sql
|   |-- 06-performance.sql
|   |-- 07-data-types.sql
|   |-- 08-postgresql-features.sql
|   |-- 09-joins.sql
|   |-- 10-subqueries.sql
|   |-- 11-schema-design.sql
|   `-- 12-transactions.sql
|-- scripts/
|   |-- backup-db.ps1
|   |-- build.ps1
|   |-- reload-data.ps1
|   |-- reset-db.ps1
|   `-- sql/
|       `-- reload-data.sql
|-- backups/              # local database backups, ignored by Git
`-- solutions/
    |-- 01-novice-solutions.sql
    |-- 02-intermediate-solutions.sql
    |-- 03-advanced-solutions.sql
    |-- 04-database-objects-solutions.sql
    |-- 05-ddl-dml-solutions.sql
    |-- 06-performance-solutions.sql
    |-- 07-data-types-solutions.sql
    |-- 08-postgresql-features-solutions.sql
    |-- 09-joins-solutions.sql
    |-- 10-subqueries-solutions.sql
    |-- 11-schema-design-solutions.sql
    `-- 12-transactions-solutions.sql
```

## What You Will Learn

- Novice: `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, basic aggregates
- Intermediate: `GROUP BY`, `HAVING`, `CASE`, joins, date-based summaries
- Advanced: CTEs, window functions, ranking, running totals, business analysis
- Database objects: functions, procedures, indexes, views, materialized views, triggers
- Database design: `CREATE`, `ALTER`, `INSERT`, `UPDATE`, `DELETE`, `UPSERT`, constraints
- Data types: `TEXT`, `VARCHAR`, `NUMERIC`, `BOOLEAN`, `UUID`, `JSONB`, arrays, `NULL`
- PostgreSQL features: `RETURNING`, `ON CONFLICT`, `generate_series()`, `FILTER`, `DISTINCT ON`, `ILIKE`
- Relational querying: join types, self joins, anti joins, and subqueries with `EXISTS`
- Schema design: primary keys, foreign keys, unique rules, defaults, and check constraints
- Transactions: `BEGIN`, `COMMIT`, `ROLLBACK`, and savepoints
- Performance basics: `EXPLAIN`, `EXPLAIN ANALYZE`, and query plan inspection

## Learning Workspace

This repo has three learning layers:

- `lessons/`: guided examples you can run directly
- `exercises/`: practice prompts without answers
- `solutions/`: one possible answer set for the exercises

Recommended flow:

1. Run a lesson file and study the results.
2. Try the matching exercise file on your own.
3. Compare your answer with the matching solution file.

## Learning Map

### Lessons

- [01-novice.sql](lessons/01-novice.sql): `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, aggregates
- [02-intermediate.sql](lessons/02-intermediate.sql): `GROUP BY`, `HAVING`, `CASE`, joins
- [03-advanced.sql](lessons/03-advanced.sql): CTEs, ranking, `LAG`, running totals
- [04-database-objects.sql](lessons/04-database-objects.sql): function, procedure, index, view, materialized view, trigger
- [05-ddl-dml.sql](lessons/05-ddl-dml.sql): `CREATE`, `ALTER`, `INSERT`, `UPDATE`, `DELETE`, `UPSERT`, constraints
- [06-performance.sql](lessons/06-performance.sql): `EXPLAIN`, `EXPLAIN ANALYZE`, reading query plans
- [07-data-types.sql](lessons/07-data-types.sql): `TEXT`, `VARCHAR`, `NUMERIC`, `BOOLEAN`, `UUID`, `JSONB`, arrays, `COALESCE`
- [08-postgresql-features.sql](lessons/08-postgresql-features.sql): `RETURNING`, `ON CONFLICT`, `generate_series()`, `FILTER`, `DISTINCT ON`, `ILIKE`, `ANY`, `unnest()`
- [09-joins.sql](lessons/09-joins.sql): `INNER JOIN`, `LEFT JOIN`, self join, anti join, and bad join examples
- [10-subqueries.sql](lessons/10-subqueries.sql): scalar subqueries, correlated subqueries, derived tables, `EXISTS`, `NOT EXISTS`
- [11-schema-design.sql](lessons/11-schema-design.sql): Superstore customer/product dimensions, order-item facts, foreign keys, check constraints, defaults
- [12-transactions.sql](lessons/12-transactions.sql): `BEGIN`, `COMMIT`, `ROLLBACK`, savepoints, and transaction safety

### Exercises

- [01-novice-exercises.sql](exercises/01-novice-exercises.sql): beginner `SELECT`, filter, sort, and aggregate practice
- [02-intermediate-exercises.sql](exercises/02-intermediate-exercises.sql): grouped analysis, `HAVING`, `CASE`, and date-table joins
- [03-advanced-exercises.sql](exercises/03-advanced-exercises.sql): CTEs, window functions, ranking, and month-over-month analysis
- [04-database-objects-exercises.sql](exercises/04-database-objects-exercises.sql): functions, procedures, indexes, views, materialized views, and triggers
- [05-ddl-dml-exercises.sql](exercises/05-ddl-dml-exercises.sql): schema changes, data modification, constraints, and upserts
- [06-performance-exercises.sql](exercises/06-performance-exercises.sql): plan reading and index-tuning practice
- [07-data-types-exercises.sql](exercises/07-data-types-exercises.sql): PostgreSQL types, JSONB, arrays, time zones, and `NULL`
- [08-postgresql-features-exercises.sql](exercises/08-postgresql-features-exercises.sql): PostgreSQL-only query features such as `RETURNING`, `ON CONFLICT`, and `DISTINCT ON`
- [09-joins-exercises.sql](exercises/09-joins-exercises.sql): join practice including inner joins, left joins, anti joins, and self joins
- [10-subqueries-exercises.sql](exercises/10-subqueries-exercises.sql): scalar subqueries, correlated subqueries, derived tables, and `EXISTS`
- [11-schema-design-exercises.sql](exercises/11-schema-design-exercises.sql): keys, constraints, and normalized Superstore-style tables
- [12-transactions-exercises.sql](exercises/12-transactions-exercises.sql): transaction control, savepoints, commits, and rollbacks

### Solutions

- [01-novice-solutions.sql](solutions/01-novice-solutions.sql)
- [02-intermediate-solutions.sql](solutions/02-intermediate-solutions.sql)
- [03-advanced-solutions.sql](solutions/03-advanced-solutions.sql)
- [04-database-objects-solutions.sql](solutions/04-database-objects-solutions.sql)
- [05-ddl-dml-solutions.sql](solutions/05-ddl-dml-solutions.sql)
- [06-performance-solutions.sql](solutions/06-performance-solutions.sql)
- [07-data-types-solutions.sql](solutions/07-data-types-solutions.sql)
- [08-postgresql-features-solutions.sql](solutions/08-postgresql-features-solutions.sql)
- [09-joins-solutions.sql](solutions/09-joins-solutions.sql)
- [10-subqueries-solutions.sql](solutions/10-subqueries-solutions.sql)
- [11-schema-design-solutions.sql](solutions/11-schema-design-solutions.sql)
- [12-transactions-solutions.sql](solutions/12-transactions-solutions.sql)

## Prerequisites

- Docker Desktop
- Docker Compose

## Setup

### 1. Create `.env`

Create a `.env` file in the project root:

```env
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=mydb

PGADMIN_EMAIL=admin@example.com
PGADMIN_PASSWORD=admin

POSTGRES_HOST_PORT=5432
PGADMIN_HOST_PORT=5050
```

### 2. Start the services

```bash
docker compose up -d
```

This starts PostgreSQL and pgAdmin. When PostgreSQL initializes a brand new `postgres_data` volume, it runs [01-load-data.sql](init-db/01-load-data.sql) once to create and load the learning tables.

View logs:

```bash
docker compose logs -f postgres
```

Stop the services:

```bash
docker compose down
```

Reset the database and rebuild everything from scratch:

```bash
docker compose down -v
docker compose up -d
```

Or use the helper script:

```powershell
./scripts/reset-db.ps1
```

Reload CSV data manually without restarting the stack:

```powershell
./scripts/reload-data.ps1
```

Create a local database backup:

```powershell
./scripts/backup-db.ps1
```

Backups are written to `backups/` as timestamped `.backup` files. The `backups/` directory is ignored by Git.

### 3. Open PostgreSQL

```bash
docker compose exec postgres psql -U ${POSTGRES_USER} -d ${POSTGRES_DB}
```

Or use pgAdmin:

- URL: `http://localhost:5050`
- Email: value from `PGADMIN_EMAIL`
- Password: value from `PGADMIN_PASSWORD`

For pgAdmin server registration:

- Host: `postgres`
- Port: `5432`
- Username: value from `POSTGRES_USER`
- Password: value from `POSTGRES_PASSWORD`
- Database: value from `POSTGRES_DB`

## Loaded Tables

The startup flow works like this:

- [01-load-data.sql](init-db/01-load-data.sql) runs when PostgreSQL initializes a brand new database volume
- [reload-data.sql](scripts/sql/reload-data.sql) only runs when you execute [reload-data.ps1](scripts/reload-data.ps1) manually

Loaded tables:

- `periode`
- `superstore`

You can verify the tables:

```sql
\dt
```

And inspect row counts:

```sql
SELECT COUNT(*) FROM periode;
SELECT COUNT(*) FROM superstore;
```

## Dataset Overview

### `periode`

This is a date dimension table with one row per day and columns such as:

- `date_actual`
- `day_name`
- `week_of_year`
- `month_actual`
- `month_name`
- `quarter_actual`
- `year_actual`
- `weekend_flag`

### `superstore`

This is a sales dataset with order, customer, geography, product, and financial fields such as:

- `order_id`
- `order_date`
- `ship_date`
- `ship_mode`
- `customer_name`
- `segment`
- `country`
- `city`
- `state`
- `region`
- `category`
- `sub_category`
- `product_name`
- `sales`
- `quantity`
- `discount`
- `profit`

## Suggested Learning Order

1. Start with [01-novice.sql](lessons/01-novice.sql), then attempt [01-novice-exercises.sql](exercises/01-novice-exercises.sql), and compare with [01-novice-solutions.sql](solutions/01-novice-solutions.sql).
2. Move to [02-intermediate.sql](lessons/02-intermediate.sql), then complete [02-intermediate-exercises.sql](exercises/02-intermediate-exercises.sql), and review [02-intermediate-solutions.sql](solutions/02-intermediate-solutions.sql).
3. Continue with [03-advanced.sql](lessons/03-advanced.sql), then solve [03-advanced-exercises.sql](exercises/03-advanced-exercises.sql), and check [03-advanced-solutions.sql](solutions/03-advanced-solutions.sql).
4. Study [04-database-objects.sql](lessons/04-database-objects.sql), then attempt [04-database-objects-exercises.sql](exercises/04-database-objects-exercises.sql), and compare with [04-database-objects-solutions.sql](solutions/04-database-objects-solutions.sql).
5. Practice schema changes and data modification in [05-ddl-dml.sql](lessons/05-ddl-dml.sql), then complete [05-ddl-dml-exercises.sql](exercises/05-ddl-dml-exercises.sql), and review [05-ddl-dml-solutions.sql](solutions/05-ddl-dml-solutions.sql).
6. Learn plan reading and index-aware tuning with [06-performance.sql](lessons/06-performance.sql), then work through [06-performance-exercises.sql](exercises/06-performance-exercises.sql) and check [06-performance-solutions.sql](solutions/06-performance-solutions.sql).
7. Learn how PostgreSQL stores and interprets values with [07-data-types.sql](lessons/07-data-types.sql), then complete [07-data-types-exercises.sql](exercises/07-data-types-exercises.sql) and review [07-data-types-solutions.sql](solutions/07-data-types-solutions.sql).
8. Explore PostgreSQL-only query features in [08-postgresql-features.sql](lessons/08-postgresql-features.sql), then try [08-postgresql-features-exercises.sql](exercises/08-postgresql-features-exercises.sql) and compare with [08-postgresql-features-solutions.sql](solutions/08-postgresql-features-solutions.sql).
9. Strengthen relational thinking with [09-joins.sql](lessons/09-joins.sql), then solve [09-joins-exercises.sql](exercises/09-joins-exercises.sql) and check [09-joins-solutions.sql](solutions/09-joins-solutions.sql).
10. Practice query decomposition in [10-subqueries.sql](lessons/10-subqueries.sql), then work through [10-subqueries-exercises.sql](exercises/10-subqueries-exercises.sql) and compare with [10-subqueries-solutions.sql](solutions/10-subqueries-solutions.sql).
11. Study constraints and table relationships in [11-schema-design.sql](lessons/11-schema-design.sql), then attempt [11-schema-design-exercises.sql](exercises/11-schema-design-exercises.sql) and review [11-schema-design-solutions.sql](solutions/11-schema-design-solutions.sql).
12. Learn transaction safety with [12-transactions.sql](lessons/12-transactions.sql), then complete [12-transactions-exercises.sql](exercises/12-transactions-exercises.sql) and compare with [12-transactions-solutions.sql](solutions/12-transactions-solutions.sql).

## Notes

- Initialization scripts in `init-db/` only run when PostgreSQL creates a fresh database volume.
- If you want to rerun the CSV load manually without restarting the stack, use [reload-data.ps1](scripts/reload-data.ps1).
- If you want a completely fresh database volume and startup flow, use [reset-db.ps1](scripts/reset-db.ps1).
- If you change [01-load-data.sql](init-db/01-load-data.sql), use `docker compose down -v` before starting again.
- The table name is `periode`, while the source CSV file is `period.csv`.
- [07-data-types.sql](lessons/07-data-types.sql) enables the `pgcrypto` extension so `gen_random_uuid()` works on a fresh database.

## Additional Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [pgAdmin Documentation](https://www.pgadmin.org/docs/)
