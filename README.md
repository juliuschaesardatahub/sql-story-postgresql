# SQL Story PostgreSQL

`sql-story-postgresql` is a hands-on PostgreSQL learning repository for studying SQL from novice to advanced. It uses Docker to start PostgreSQL and pgAdmin, then loads two datasets for real query practice:

- `periode`: a calendar table loaded from `data/period.csv`
- `superstore`: a retail sales table loaded from `data/superstore.csv`

This repo is designed as a learning journey, not just a Docker setup. You can start with simple `SELECT` queries, move into grouped analysis, and then work with joins, CTEs, window functions, PostgreSQL-specific features, schema design, transactions, and query tuning.

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

This repo now has three learning layers:

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
- [11-schema-design.sql](lessons/11-schema-design.sql): primary keys, foreign keys, unique constraints, check constraints, defaults
- [12-transactions.sql](lessons/12-transactions.sql): `BEGIN`, `COMMIT`, `ROLLBACK`, savepoints, transaction safety

### Exercises

- [01-novice-exercises.sql](exercises/01-novice-exercises.sql): 7 beginner questions
- [02-intermediate-exercises.sql](exercises/02-intermediate-exercises.sql): 7 grouped-analysis and join questions
- [03-advanced-exercises.sql](exercises/03-advanced-exercises.sql): 10 harder questions with CTEs, windows, ranking, and month-over-month analysis
- [04-database-objects-exercises.sql](exercises/04-database-objects-exercises.sql): 6 practice prompts for functions, procedures, indexes, views, materialized views, and triggers
- [05-ddl-dml-exercises.sql](exercises/05-ddl-dml-exercises.sql): 7 schema and data-change practice prompts
- [06-performance-exercises.sql](exercises/06-performance-exercises.sql): 6 plan-reading and index-tuning prompts
- [07-data-types-exercises.sql](exercises/07-data-types-exercises.sql): 6 questions on PostgreSQL types, JSONB, arrays, and `NULL`
- [08-postgresql-features-exercises.sql](exercises/08-postgresql-features-exercises.sql): 7 prompts for PostgreSQL-only query features
- [09-joins-exercises.sql](exercises/09-joins-exercises.sql): 6 join practice prompts including anti joins and self joins
- [10-subqueries-exercises.sql](exercises/10-subqueries-exercises.sql): 6 subquery and `EXISTS` prompts
- [11-schema-design-exercises.sql](exercises/11-schema-design-exercises.sql): 6 practice prompts for keys, constraints, and normalized tables
- [12-transactions-exercises.sql](exercises/12-transactions-exercises.sql): 5 prompts for transaction control and savepoints

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

The startup flow now works like this:

- [01-load-data.sql](init-db/01-load-data.sql) runs when PostgreSQL initializes a brand new database volume
- [reload-data.sql](scripts/sql/reload-data.sql) only runs when you execute [reload-data.ps1](scripts/reload-data.ps1) manually

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

## Novice

At this level, focus on understanding table structure and retrieving rows.

### 1. View sample records

```sql
SELECT *
FROM superstore
LIMIT 10;
```

### 2. Select only a few columns

```sql
SELECT order_id, order_date, customer_name, sales, profit
FROM superstore
LIMIT 10;
```

### 3. Filter with `WHERE`

```sql
SELECT order_id, customer_name, region, sales
FROM superstore
WHERE region = 'West';
```

### 4. Sort with `ORDER BY`

```sql
SELECT product_name, sales, profit
FROM superstore
ORDER BY sales DESC
LIMIT 10;
```

### 5. Use basic aggregate functions

```sql
SELECT
    COUNT(*) AS total_rows,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(sales) AS avg_sales
FROM superstore;
```

### 6. Explore the calendar table

```sql
SELECT date_actual, day_name, month_name, year_actual
FROM periode
LIMIT 10;
```

### 7. Find loss-making rows

```sql
SELECT order_id, product_name, sales, profit
FROM superstore
WHERE profit < 0
ORDER BY profit;
```

Practice goals:

- selecting columns
- filtering rows
- sorting results
- using `COUNT`, `SUM`, and `AVG`

## Intermediate

At this level, focus on summarizing data and connecting tables.

### 1. Sales by region

```sql
SELECT
    region,
    COUNT(*) AS total_rows,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;
```

### 2. Profit by category

```sql
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;
```

### 3. Filter grouped results with `HAVING`

```sql
SELECT
    state,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY state
HAVING SUM(sales) > 50000
ORDER BY total_sales DESC;
```

### 4. Use `CASE` to classify profit

```sql
SELECT
    order_id,
    product_name,
    sales,
    profit,
    CASE
        WHEN profit < 0 THEN 'Loss'
        WHEN profit = 0 THEN 'Break Even'
        ELSE 'Profit'
    END AS profit_status
FROM superstore
LIMIT 20;
```

### 5. Join `superstore` with `periode`

```sql
SELECT
    p.year_actual,
    p.month_name,
    COUNT(*) AS total_orders,
    SUM(s.sales) AS total_sales
FROM superstore s
JOIN periode p
    ON s.order_date = p.date_actual
GROUP BY p.year_actual, p.month_actual, p.month_name
ORDER BY p.year_actual, p.month_actual;
```

### 6. Average shipping delay by ship mode

```sql
SELECT
    ship_mode,
    AVG(ship_date - order_date) AS avg_shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY avg_shipping_days;
```

### 7. Top customers by sales

```sql
SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;
```

Practice goals:

- grouping and aggregation
- filtering grouped results
- `CASE` expressions
- joining fact data to a date table

## Advanced

At this level, focus on analytical SQL patterns used in reporting and dashboards.

### 1. Monthly sales with running total

```sql
WITH monthly_sales AS (
    SELECT
        p.year_actual,
        p.month_actual,
        p.month_name,
        SUM(s.sales) AS total_sales
    FROM superstore s
    JOIN periode p
        ON s.order_date = p.date_actual
    GROUP BY p.year_actual, p.month_actual, p.month_name
)
SELECT
    year_actual,
    month_actual,
    month_name,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY year_actual, month_actual
    ) AS running_sales
FROM monthly_sales
ORDER BY year_actual, month_actual;
```

### 2. Rank products by profit inside each category

```sql
WITH product_profit AS (
    SELECT
        category,
        product_name,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY category, product_name
)
SELECT
    category,
    product_name,
    total_profit,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY total_profit DESC
    ) AS profit_rank
FROM product_profit
ORDER BY category, profit_rank, product_name;
```

### 3. Find the top-selling month in each year

```sql
WITH monthly_sales AS (
    SELECT
        p.year_actual,
        p.month_actual,
        p.month_name,
        SUM(s.sales) AS total_sales
    FROM superstore s
    JOIN periode p
        ON s.order_date = p.date_actual
    GROUP BY p.year_actual, p.month_actual, p.month_name
),
ranked_months AS (
    SELECT
        year_actual,
        month_actual,
        month_name,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY year_actual
            ORDER BY total_sales DESC
        ) AS rn
    FROM monthly_sales
)
SELECT
    year_actual,
    month_name,
    total_sales
FROM ranked_months
WHERE rn = 1
ORDER BY year_actual;
```

### 4. Compare each order to the customer's previous order

```sql
SELECT
    customer_id,
    customer_name,
    order_date,
    sales,
    LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM superstore
ORDER BY customer_id, order_date;
```

### 5. Find high-discount, low-profit products

```sql
SELECT
    sub_category,
    product_name,
    AVG(discount) AS avg_discount,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY sub_category, product_name
HAVING AVG(discount) > 0.3
   AND SUM(profit) < 0
ORDER BY avg_discount DESC, total_profit;
```

### 6. Compare weekend and weekday sales

```sql
SELECT
    CASE
        WHEN p.weekend_flag = 1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS total_orders,
    SUM(s.sales) AS total_sales,
    SUM(s.profit) AS total_profit
FROM superstore s
JOIN periode p
    ON s.order_date = p.date_actual
GROUP BY
    CASE
        WHEN p.weekend_flag = 1 THEN 'Weekend'
        ELSE 'Weekday'
    END
ORDER BY day_type;
```

Practice goals:

- common table expressions
- window functions
- ranking and top-N analysis
- cumulative metrics
- time-based analysis

## Database Objects Practice

These examples use the same `periode` and `superstore` tables, but move beyond `SELECT` queries into reusable database objects.

### Stored function

Use a PostgreSQL function when you want reusable query logic with input parameters.

```sql
CREATE OR REPLACE FUNCTION get_sales_by_region(p_region VARCHAR)
RETURNS TABLE (
    order_id VARCHAR,
    order_date DATE,
    customer_name VARCHAR,
    sales DECIMAL,
    profit DECIMAL
)
LANGUAGE sql
AS $$
    SELECT
        order_id,
        order_date,
        customer_name,
        sales,
        profit
    FROM superstore
    WHERE region = p_region
    ORDER BY order_date, order_id;
$$;
```

Example:

```sql
SELECT *
FROM get_sales_by_region('West')
LIMIT 20;
```

### Stored procedure

Use a stored procedure when you want to perform actions, not just return a result set.

```sql
CREATE OR REPLACE PROCEDURE refresh_monthly_sales_summary()
LANGUAGE plpgsql
AS $$
BEGIN
    DROP TABLE IF EXISTS monthly_sales_summary;

    CREATE TABLE monthly_sales_summary AS
    SELECT
        p.year_actual,
        p.month_actual,
        p.month_name,
        SUM(s.sales) AS total_sales,
        SUM(s.profit) AS total_profit,
        COUNT(*) AS total_orders
    FROM superstore s
    JOIN periode p
        ON s.order_date = p.date_actual
    GROUP BY p.year_actual, p.month_actual, p.month_name;
END;
$$;
```

Example:

```sql
CALL refresh_monthly_sales_summary();

SELECT *
FROM monthly_sales_summary
ORDER BY year_actual, month_actual;
```

### Index

Indexes help PostgreSQL find rows faster, especially for filters, joins, and sorts.

```sql
CREATE INDEX idx_superstore_order_date
ON superstore(order_date);

CREATE INDEX idx_superstore_region_category
ON superstore(region, category);

CREATE INDEX idx_periode_date_actual
ON periode(date_actual);
```

Good use cases in this repo:

- filtering `superstore` by `order_date`
- grouping or filtering by `region` and `category`
- joining `superstore.order_date` to `periode.date_actual`

### View

A view stores a query definition and makes it easier to reuse reporting logic.

```sql
CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT
    p.year_actual,
    p.month_actual,
    p.month_name,
    SUM(s.sales) AS total_sales,
    SUM(s.profit) AS total_profit,
    COUNT(*) AS total_orders
FROM superstore s
JOIN periode p
    ON s.order_date = p.date_actual
GROUP BY p.year_actual, p.month_actual, p.month_name;
```

Example:

```sql
SELECT *
FROM vw_monthly_sales
ORDER BY year_actual, month_actual;
```

### Materialized view

A materialized view stores query results physically, which can be much faster for repeated reporting queries.

```sql
CREATE MATERIALIZED VIEW mv_top_products_by_profit AS
SELECT
    category,
    sub_category,
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY category, sub_category, product_name;
```

Example:

```sql
SELECT *
FROM mv_top_products_by_profit
ORDER BY total_profit DESC
LIMIT 20;
```

Refresh when source data changes:

```sql
REFRESH MATERIALIZED VIEW mv_top_products_by_profit;
```

### Trigger

A trigger runs automatically when data changes. Since `superstore` is imported from CSV, a simple learning example is to log inserted rows into an audit table.

```sql
CREATE TABLE superstore_audit (
    audit_id BIGSERIAL PRIMARY KEY,
    row_id INTEGER,
    action_type VARCHAR(20),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_superstore_insert()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO superstore_audit (row_id, action_type)
    VALUES (NEW.row_id, 'INSERT');

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_superstore_insert
AFTER INSERT ON superstore
FOR EACH ROW
EXECUTE FUNCTION log_superstore_insert();
```

Example test:

```sql
INSERT INTO superstore (
    row_id, order_id, order_date, ship_date, ship_mode,
    customer_id, customer_name, segment, country_code, country,
    city, state, state_code, postal_code, region,
    product_id, category, sub_category, product_name,
    sales, quantity, discount, profit
) VALUES (
    999999, 'TEST-ORDER-001', '2017-01-01', '2017-01-03', 'Second Class',
    'TEST-001', 'SQL Learner', 'Consumer', 'USA', 'United States',
    'Test City', 'Test State', 'TS', '00000', 'West',
    'TEST-PROD-001', 'Technology', 'Accessories', 'Practice Product',
    100.00, 1, 0.00, 25.00
);

SELECT *
FROM superstore_audit
ORDER BY changed_at DESC;
```

Practice goals:

- building reusable database objects
- understanding when to use a function vs procedure
- improving query performance with indexes
- separating reporting logic with views
- caching expensive summaries with materialized views
- automating side effects with triggers

## Suggested Learning Order

1. Start with [01-novice.sql](lessons/01-novice.sql), then attempt [01-novice-exercises.sql](exercises/01-novice-exercises.sql), and compare with [01-novice-solutions.sql](solutions/01-novice-solutions.sql).
2. Move to [02-intermediate.sql](lessons/02-intermediate.sql), then complete [02-intermediate-exercises.sql](exercises/02-intermediate-exercises.sql), and review [02-intermediate-solutions.sql](solutions/02-intermediate-solutions.sql).
3. Continue with [03-advanced.sql](lessons/03-advanced.sql), then solve all 10 questions in [03-advanced-exercises.sql](exercises/03-advanced-exercises.sql), and check [03-advanced-solutions.sql](solutions/03-advanced-solutions.sql).
4. Study [04-database-objects.sql](lessons/04-database-objects.sql), then attempt [04-database-objects-exercises.sql](exercises/04-database-objects-exercises.sql), and compare with [04-database-objects-solutions.sql](solutions/04-database-objects-solutions.sql).
5. Practice schema changes and data modification in [05-ddl-dml.sql](lessons/05-ddl-dml.sql), then complete [05-ddl-dml-exercises.sql](exercises/05-ddl-dml-exercises.sql), and review [05-ddl-dml-solutions.sql](solutions/05-ddl-dml-solutions.sql).
6. Learn how PostgreSQL stores and interprets values with [07-data-types.sql](lessons/07-data-types.sql), then complete [07-data-types-exercises.sql](exercises/07-data-types-exercises.sql) and review [07-data-types-solutions.sql](solutions/07-data-types-solutions.sql).
7. Explore PostgreSQL-only query features in [08-postgresql-features.sql](lessons/08-postgresql-features.sql), then try [08-postgresql-features-exercises.sql](exercises/08-postgresql-features-exercises.sql) and compare with [08-postgresql-features-solutions.sql](solutions/08-postgresql-features-solutions.sql).
8. Strengthen relational thinking with [09-joins.sql](lessons/09-joins.sql), then solve [09-joins-exercises.sql](exercises/09-joins-exercises.sql) and check [09-joins-solutions.sql](solutions/09-joins-solutions.sql).
9. Practice query decomposition in [10-subqueries.sql](lessons/10-subqueries.sql), then work through [10-subqueries-exercises.sql](exercises/10-subqueries-exercises.sql) and compare with [10-subqueries-solutions.sql](solutions/10-subqueries-solutions.sql).
10. Study constraints and table relationships in [11-schema-design.sql](lessons/11-schema-design.sql), then attempt [11-schema-design-exercises.sql](exercises/11-schema-design-exercises.sql) and review [11-schema-design-solutions.sql](solutions/11-schema-design-solutions.sql).
11. Learn transaction safety with [12-transactions.sql](lessons/12-transactions.sql), then complete [12-transactions-exercises.sql](exercises/12-transactions-exercises.sql) and compare with [12-transactions-solutions.sql](solutions/12-transactions-solutions.sql).
12. Finish with plan reading and index-aware tuning in [06-performance.sql](lessons/06-performance.sql), then work through [06-performance-exercises.sql](exercises/06-performance-exercises.sql) and check [06-performance-solutions.sql](solutions/06-performance-solutions.sql).

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

