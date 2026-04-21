-- Lesson 04: Database Objects
-- Goal: learn functions, procedures, indexes, views, materialized views, and triggers.

-- 1. Function: reusable query logic.
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

SELECT *
FROM get_sales_by_region('West')
LIMIT 20;

-- 2. Procedure: build a summary table.
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

CALL refresh_monthly_sales_summary();

-- 3. Indexes: support filters and joins.
CREATE INDEX IF NOT EXISTS idx_superstore_order_date
ON superstore(order_date);

CREATE INDEX IF NOT EXISTS idx_superstore_region_category
ON superstore(region, category);

CREATE INDEX IF NOT EXISTS idx_periode_date_actual
ON periode(date_actual);

-- 4. View: reusable reporting query.
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

-- 5. Materialized view: persisted query results.
DROP MATERIALIZED VIEW IF EXISTS mv_top_products_by_profit;

CREATE MATERIALIZED VIEW mv_top_products_by_profit AS
SELECT
    category,
    sub_category,
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY category, sub_category, product_name;

REFRESH MATERIALIZED VIEW mv_top_products_by_profit;

-- 6. Trigger: audit inserted rows.
CREATE TABLE IF NOT EXISTS superstore_audit (
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

DROP TRIGGER IF EXISTS trg_superstore_insert ON superstore;

CREATE TRIGGER trg_superstore_insert
AFTER INSERT ON superstore
FOR EACH ROW
EXECUTE FUNCTION log_superstore_insert();
