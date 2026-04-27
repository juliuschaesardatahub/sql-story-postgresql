-- Solutions 08: PostgreSQL-Specific Features

-- 1.
INSERT INTO lesson_order_reviews (row_id, order_id, product_name, review_status)
SELECT
    row_id,
    order_id,
    product_name,
    'needs-review'
FROM superstore
WHERE profit < 0
ORDER BY profit
OFFSET 1
LIMIT 1
RETURNING *;

-- 2.
INSERT INTO lesson_order_reviews (row_id, order_id, product_name, review_status)
SELECT
    row_id,
    order_id,
    product_name,
    'reviewed'
FROM superstore
WHERE profit < 0
ORDER BY profit
OFFSET 1
LIMIT 1
ON CONFLICT (row_id)
DO UPDATE SET
    review_status = EXCLUDED.review_status,
    reviewed_at = CURRENT_TIMESTAMP
RETURNING *;

-- 3.
SELECT
    generated_day::DATE AS generated_day
FROM generate_series(
    DATE '2017-06-01',
    DATE '2017-06-05',
    INTERVAL '1 day'
) AS generated_day;

-- 4.
SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE profit > 0) AS profitable_orders,
    SUM(sales) FILTER (WHERE region = 'South') AS south_sales
FROM superstore;

-- 5.
SELECT DISTINCT ON (customer_id)
    customer_id,
    customer_name,
    order_date,
    sales
FROM superstore
ORDER BY customer_id, order_date DESC, sales DESC;

-- 6.
SELECT
    customer_id,
    customer_name
FROM superstore
WHERE customer_name ILIKE '%john%'
ORDER BY customer_name;

-- 7.
SELECT
    order_id,
    region,
    sales
FROM superstore
WHERE region = ANY (ARRAY['Central', 'South'])
ORDER BY sales DESC;
