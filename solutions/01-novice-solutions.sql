-- Solutions 01: Novice SQL

-- 1.
SELECT *
FROM superstore
LIMIT 15;

-- 2.
SELECT order_id, customer_name, sales
FROM superstore
WHERE region = 'East';

-- 3.
SELECT product_name, profit
FROM superstore
ORDER BY profit
LIMIT 10;

-- 4.
SELECT COUNT(*) AS total_rows
FROM superstore;

-- 5.
SELECT AVG(discount) AS avg_discount
FROM superstore;

-- 6.
SELECT DISTINCT ship_mode
FROM superstore
ORDER BY ship_mode;

-- 7.
SELECT date_actual
FROM periode
WHERE month_name = 'January'
ORDER BY date_actual;
