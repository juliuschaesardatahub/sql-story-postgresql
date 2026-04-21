-- Lesson 06: Query Tuning and Debugging
-- Goal: learn EXPLAIN, EXPLAIN ANALYZE, and how indexes affect plans.

-- 1. Inspect a filter query before indexing.
EXPLAIN
SELECT *
FROM superstore
WHERE order_date BETWEEN DATE '2017-01-01' AND DATE '2017-12-31';

-- 2. Inspect a join query.
EXPLAIN
SELECT
    p.year_actual,
    p.month_name,
    SUM(s.sales) AS total_sales
FROM superstore s
JOIN periode p
    ON s.order_date = p.date_actual
GROUP BY p.year_actual, p.month_actual, p.month_name
ORDER BY p.year_actual, p.month_actual;

-- 3. Compare with actual execution statistics.
EXPLAIN ANALYZE
SELECT
    region,
    category,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY region, category
ORDER BY total_sales DESC;

-- 4. Inspect a top-N query.
EXPLAIN ANALYZE
SELECT product_name, sales, profit
FROM superstore
ORDER BY sales DESC
LIMIT 10;
