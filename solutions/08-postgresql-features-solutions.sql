-- Solutions 08: PostgreSQL-Specific Features

-- 1.
INSERT INTO lesson_feature_enrollments (learner_email, learner_name, preferred_track)
VALUES ('john@example.com', 'John', 'reporting')
RETURNING *;

-- 2.
INSERT INTO lesson_feature_enrollments (learner_email, learner_name, preferred_track)
VALUES ('john@example.com', 'John Tan', 'advanced-sql')
ON CONFLICT (learner_email)
DO UPDATE SET
    learner_name = EXCLUDED.learner_name,
    preferred_track = EXCLUDED.preferred_track
RETURNING *;

-- 3.
SELECT
    generated_day::DATE AS generated_day
FROM generate_series(
    DATE '2026-06-01',
    DATE '2026-06-05',
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
