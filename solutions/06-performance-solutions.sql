-- Solutions 06: Performance and Query Plans

-- 1.
EXPLAIN
SELECT *
FROM superstore
WHERE region = 'West';

-- 2.
EXPLAIN ANALYZE
SELECT
    sub_category,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- 3.
CREATE INDEX IF NOT EXISTS idx_superstore_region
ON superstore(region);

EXPLAIN
SELECT *
FROM superstore
WHERE region = 'West';

-- 4.
EXPLAIN
SELECT
    p.year_actual,
    COUNT(*) AS total_orders,
    SUM(s.sales) AS total_sales
FROM superstore s
JOIN periode p
    ON s.order_date = p.date_actual
GROUP BY p.year_actual
ORDER BY p.year_actual;

-- 5.
EXPLAIN ANALYZE
SELECT
    customer_id,
    customer_name,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC
LIMIT 5;

-- 6.
CREATE INDEX IF NOT EXISTS idx_superstore_customer_id_perf
ON superstore(customer_id);

EXPLAIN ANALYZE
SELECT
    customer_id,
    customer_name,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC
LIMIT 5;
