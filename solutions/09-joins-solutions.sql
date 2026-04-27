-- Solutions 09: Join Patterns

-- 1.
SELECT
    o.order_id,
    c.customer_name,
    o.order_date
FROM lesson_join_orders o
JOIN lesson_join_customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_date, o.order_id;

-- 2.
SELECT
    p.product_id,
    p.product_name,
    COUNT(oi.row_id) AS item_count
FROM lesson_join_products p
LEFT JOIN lesson_join_order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY item_count, p.product_name;

-- 3.
SELECT
    a.customer_name AS customer_a,
    b.customer_name AS customer_b,
    a.region
FROM lesson_join_customers a
JOIN lesson_join_customers b
    ON a.region = b.region
   AND a.customer_id < b.customer_id
ORDER BY a.region, a.customer_name, b.customer_name;

-- 4.
SELECT
    p.product_id,
    p.product_name
FROM lesson_join_products p
LEFT JOIN lesson_join_order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_name;

-- 5.
SELECT
    c.customer_name,
    p.product_name,
    oi.quantity,
    oi.sales
FROM lesson_join_order_items oi
JOIN lesson_join_orders o
    ON oi.order_id = o.order_id
JOIN lesson_join_customers c
    ON o.customer_id = c.customer_id
JOIN lesson_join_products p
    ON oi.product_id = p.product_id
ORDER BY oi.sales DESC, c.customer_name;
