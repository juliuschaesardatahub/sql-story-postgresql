-- Solutions 02: Intermediate SQL

-- 1.
SELECT
    segment,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;

-- 2.
SELECT
    state,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY state
ORDER BY total_profit DESC;

-- 3.
SELECT
    category,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY category
HAVING SUM(sales) > 200000
ORDER BY total_sales DESC;

-- 4.
SELECT
    p.year_actual,
    COUNT(*) AS total_orders
FROM superstore s
JOIN periode p
    ON s.order_date = p.date_actual
GROUP BY p.year_actual
ORDER BY p.year_actual;

-- 5.
SELECT
    ship_mode,
    AVG(sales) AS avg_sales
FROM superstore
GROUP BY ship_mode
ORDER BY avg_sales DESC;

-- 6.
SELECT
    customer_id,
    customer_name,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC
LIMIT 5;

-- 7.
SELECT
    order_id,
    discount,
    CASE
        WHEN discount > 0 THEN 'Discounted'
        ELSE 'Full Price'
    END AS pricing_label
FROM superstore;
