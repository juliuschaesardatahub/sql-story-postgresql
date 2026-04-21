-- Lesson 01: Novice SQL
-- Goal: learn SELECT, WHERE, ORDER BY, LIMIT, and basic aggregates.

-- 1. Inspect the table.
SELECT *
FROM superstore
LIMIT 10;

-- 2. Select only the columns you need.
SELECT order_id, order_date, customer_name, sales, profit
FROM superstore
LIMIT 10;

-- 3. Filter rows.
SELECT order_id, customer_name, region, sales
FROM superstore
WHERE region = 'West';

-- 4. Sort rows.
SELECT product_name, sales, profit
FROM superstore
ORDER BY sales DESC
LIMIT 10;

-- 5. Aggregate data.
SELECT
    COUNT(*) AS total_rows,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(sales) AS avg_sales
FROM superstore;

-- 6. Explore the date dimension.
SELECT date_actual, day_name, month_name, year_actual
FROM periode
LIMIT 10;

-- 7. Find rows with negative profit.
SELECT order_id, product_name, sales, profit
FROM superstore
WHERE profit < 0
ORDER BY profit;
