-- Lesson 09: Join Patterns
-- Goal: learn the most common join types and how to avoid bad join logic.

-- 1. Build small normalized practice tables.
DROP TABLE IF EXISTS lesson_join_order_items;
DROP TABLE IF EXISTS lesson_join_orders;
DROP TABLE IF EXISTS lesson_join_customers;
DROP TABLE IF EXISTS lesson_join_products;

CREATE TABLE lesson_join_customers AS
SELECT DISTINCT ON (customer_id)
    customer_id,
    customer_name,
    region
FROM superstore
ORDER BY customer_id, order_date
LIMIT 12;

CREATE TABLE lesson_join_orders AS
SELECT DISTINCT ON (s.order_id)
    s.order_id,
    s.customer_id,
    s.order_date
FROM superstore s
JOIN lesson_join_customers c
    ON s.customer_id = c.customer_id
ORDER BY s.order_id, s.order_date
LIMIT 20;

CREATE TABLE lesson_join_order_items AS
SELECT
    row_id,
    order_id,
    product_id,
    sales,
    quantity,
    profit
FROM superstore
WHERE order_id IN (
    SELECT order_id
    FROM lesson_join_orders
)
LIMIT 40;

CREATE TABLE lesson_join_products AS
WITH matched_products AS (
    SELECT DISTINCT ON (s.product_id)
        s.product_id,
        s.product_name,
        s.category
    FROM superstore s
    JOIN lesson_join_order_items oi
        ON s.product_id = oi.product_id
    ORDER BY s.product_id, s.order_date
),
extra_products AS (
    SELECT DISTINCT ON (s.product_id)
        s.product_id,
        s.product_name,
        s.category
    FROM superstore s
    WHERE NOT EXISTS (
        SELECT 1
        FROM matched_products mp
        WHERE mp.product_id = s.product_id
    )
    ORDER BY s.product_id, s.order_date
    LIMIT 5
)
SELECT *
FROM matched_products
UNION ALL
SELECT *
FROM extra_products;

-- 2. INNER JOIN returns matched rows only.
SELECT
    o.order_id,
    c.customer_name,
    c.region,
    o.order_date
FROM lesson_join_orders o
JOIN lesson_join_customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_date, o.order_id;

-- 3. LEFT JOIN keeps all rows from the left table.
SELECT
    p.product_id,
    p.product_name,
    COUNT(oi.row_id) AS item_count
FROM lesson_join_products p
LEFT JOIN lesson_join_order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY item_count, p.product_name;

-- 4. Self join compares rows within the same table.
SELECT
    a.customer_id,
    a.customer_name AS customer_a,
    b.customer_name AS customer_b,
    a.region
FROM lesson_join_customers a
JOIN lesson_join_customers b
    ON a.region = b.region
   AND a.customer_id < b.customer_id
ORDER BY a.region, a.customer_name, b.customer_name;

-- 5. Anti join finds rows with no match.
SELECT
    p.product_id,
    p.product_name
FROM lesson_join_products p
LEFT JOIN lesson_join_order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_name;

-- 6. Example of a risky join that can duplicate rows if the key is wrong.
SELECT
    c.region,
    COUNT(*) AS joined_rows
FROM lesson_join_customers c
JOIN lesson_join_products p
    ON c.region = c.region
GROUP BY c.region
ORDER BY c.region;

-- 7. Correct the logic by joining on real related keys.
SELECT
    c.customer_name,
    p.product_name,
    oi.sales
FROM lesson_join_order_items oi
JOIN lesson_join_orders o
    ON oi.order_id = o.order_id
JOIN lesson_join_customers c
    ON o.customer_id = c.customer_id
JOIN lesson_join_products p
    ON oi.product_id = p.product_id
ORDER BY oi.sales DESC, c.customer_name;
