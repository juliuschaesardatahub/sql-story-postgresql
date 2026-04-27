-- Lesson 08: PostgreSQL-Specific Query Features
-- Goal: learn practical PostgreSQL features using superstore and periode data.

-- 1. RETURNING gives back rows changed by INSERT.
DROP TABLE IF EXISTS lesson_order_reviews;

CREATE TABLE lesson_order_reviews (
    review_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    row_id INTEGER NOT NULL UNIQUE,
    order_id VARCHAR(50) NOT NULL,
    product_name TEXT NOT NULL,
    review_status TEXT NOT NULL,
    reviewed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO lesson_order_reviews (row_id, order_id, product_name, review_status)
SELECT
    row_id,
    order_id,
    product_name,
    'needs-review' AS review_status
FROM superstore
WHERE profit < 0
ORDER BY profit
LIMIT 1
RETURNING review_id, row_id, order_id, review_status, reviewed_at;

-- 2. ON CONFLICT supports upsert workflows.
INSERT INTO lesson_order_reviews (row_id, order_id, product_name, review_status)
SELECT
    row_id,
    order_id,
    product_name,
    'reviewed' AS review_status
FROM superstore
WHERE profit < 0
ORDER BY profit
LIMIT 1
ON CONFLICT (row_id)
DO UPDATE SET
    review_status = EXCLUDED.review_status,
    reviewed_at = CURRENT_TIMESTAMP
RETURNING review_id, row_id, order_id, review_status;

-- 3. generate_series() is useful for test data and calendars.
SELECT
    generated_day::DATE AS generated_day
FROM generate_series(
    DATE '2017-05-01',
    DATE '2017-05-07',
    INTERVAL '1 day'
) AS generated_day;

-- 4. FILTER lets you calculate multiple aggregates in one pass.
SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE profit < 0) AS loss_orders,
    SUM(sales) FILTER (WHERE region = 'West') AS west_sales
FROM superstore;

-- 5. DISTINCT ON keeps one row per grouping with custom ordering.
SELECT DISTINCT ON (customer_id)
    customer_id,
    customer_name,
    order_date,
    sales
FROM superstore
ORDER BY customer_id, order_date DESC, sales DESC;

-- 6. ILIKE performs case-insensitive pattern matching.
SELECT
    customer_name,
    city,
    state
FROM superstore
WHERE customer_name ILIKE '%smith%'
ORDER BY customer_name;

-- 7. ANY compares a value against an array.
SELECT
    order_id,
    region,
    category,
    sales
FROM superstore
WHERE region = ANY (ARRAY['West', 'East'])
ORDER BY sales DESC
LIMIT 10;

-- 8. unnest() expands arrays into rows.
SELECT
    product_id,
    unnest(ARRAY[category, sub_category, region]) AS product_attribute
FROM superstore
ORDER BY product_id, product_attribute
LIMIT 30;
