-- Solutions 04: Database Objects

-- 1.
CREATE OR REPLACE FUNCTION get_sales_by_category(p_category VARCHAR)
RETURNS TABLE (
    order_id VARCHAR,
    order_date DATE,
    product_name VARCHAR,
    sales DECIMAL,
    profit DECIMAL
)
LANGUAGE sql
AS $$
    SELECT
        order_id,
        order_date,
        product_name,
        sales,
        profit
    FROM superstore
    WHERE category = p_category
    ORDER BY order_date, order_id;
$$;

-- 2.
CREATE OR REPLACE PROCEDURE refresh_region_sales_summary()
LANGUAGE plpgsql
AS $$
BEGIN
    DROP TABLE IF EXISTS region_sales_summary;

    CREATE TABLE region_sales_summary AS
    SELECT
        region,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(*) AS total_orders
    FROM superstore
    GROUP BY region;
END;
$$;

CALL refresh_region_sales_summary();

-- 3.
CREATE INDEX IF NOT EXISTS idx_superstore_customer_id
ON superstore(customer_id);

CREATE INDEX IF NOT EXISTS idx_superstore_region_order_date
ON superstore(region, order_date);

-- 4.
CREATE OR REPLACE VIEW vw_customer_order_summary AS
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY customer_id, customer_name;

-- 5.
DROP MATERIALIZED VIEW IF EXISTS mv_sales_by_state;

CREATE MATERIALIZED VIEW mv_sales_by_state AS
SELECT
    state,
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY state, region;

REFRESH MATERIALIZED VIEW mv_sales_by_state;

-- 6.
CREATE TABLE IF NOT EXISTS superstore_update_audit (
    audit_id BIGSERIAL PRIMARY KEY,
    row_id INTEGER,
    action_type VARCHAR(20),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_superstore_update()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO superstore_update_audit (row_id, action_type)
    VALUES (NEW.row_id, 'UPDATE');

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_superstore_update ON superstore;

CREATE TRIGGER trg_superstore_update
AFTER UPDATE ON superstore
FOR EACH ROW
EXECUTE FUNCTION log_superstore_update();
