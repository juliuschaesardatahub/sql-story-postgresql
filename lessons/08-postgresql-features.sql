-- Lesson 08: PostgreSQL-Specific Query Features
-- Goal: learn practical PostgreSQL features that make everyday SQL easier.

-- 1. RETURNING gives back rows changed by INSERT.
DROP TABLE IF EXISTS lesson_feature_enrollments;

CREATE TABLE lesson_feature_enrollments (
    enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    learner_email TEXT NOT NULL UNIQUE,
    learner_name TEXT NOT NULL,
    preferred_track TEXT NOT NULL,
    enrolled_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO lesson_feature_enrollments (learner_email, learner_name, preferred_track)
VALUES ('ana@example.com', 'Ana', 'analytics')
RETURNING enrollment_id, learner_email, enrolled_at;

-- 2. ON CONFLICT supports upsert workflows.
INSERT INTO lesson_feature_enrollments (learner_email, learner_name, preferred_track)
VALUES ('ana@example.com', 'Ana Maria', 'performance')
ON CONFLICT (learner_email)
DO UPDATE SET
    learner_name = EXCLUDED.learner_name,
    preferred_track = EXCLUDED.preferred_track
RETURNING enrollment_id, learner_email, learner_name, preferred_track;

-- 3. generate_series() is useful for test data and calendars.
SELECT
    generated_day::DATE AS generated_day
FROM generate_series(
    DATE '2026-05-01',
    DATE '2026-05-07',
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
    lesson_code,
    unnest(tags) AS tag_name
FROM lesson_data_types
ORDER BY lesson_code, tag_name;
