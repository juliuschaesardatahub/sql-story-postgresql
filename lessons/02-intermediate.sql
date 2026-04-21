-- Lesson 02: Intermediate SQL
-- Goal: learn GROUP BY, HAVING, CASE, and joins.

-- 1. Sales by region.
SELECT
    region,
    COUNT(*) AS total_rows,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- 2. Profit by category.
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- 3. Group filtering with HAVING.
SELECT
    state,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY state
HAVING SUM(sales) > 50000
ORDER BY total_sales DESC;

-- 4. Classify rows with CASE.
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

-- 5. Join sales to the calendar table.
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

-- 6. Shipping delay by ship mode.
SELECT
    ship_mode,
    AVG(ship_date - order_date) AS avg_shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY avg_shipping_days;

-- 7. Top customers by sales.
SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;
