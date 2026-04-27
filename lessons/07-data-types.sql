-- Lesson 07: PostgreSQL Data Types and NULL Handling
-- Goal: learn practical PostgreSQL types using superstore and periode examples.

-- 1. Create a sandbox table enriched from real Superstore rows.
DROP TABLE IF EXISTS lesson_product_profiles;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE lesson_product_profiles (
    profile_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id VARCHAR(50) NOT NULL,
    product_name TEXT NOT NULL,
    category VARCHAR(50) NOT NULL,
    sub_category VARCHAR(50) NOT NULL,
    avg_sales NUMERIC(12, 2) NOT NULL,
    total_quantity INTEGER NOT NULL,
    has_loss BOOLEAN NOT NULL,
    external_id UUID DEFAULT gen_random_uuid(),
    tags TEXT[],
    metrics JSONB,
    first_order_date DATE NOT NULL,
    first_order_timestamp TIMESTAMP NOT NULL,
    first_order_tz TIMESTAMPTZ NOT NULL,
    notes TEXT
);

-- 2. Insert sample rows from superstore and periode.
INSERT INTO lesson_product_profiles (
    product_id,
    product_name,
    category,
    sub_category,
    avg_sales,
    total_quantity,
    has_loss,
    tags,
    metrics,
    first_order_date,
    first_order_timestamp,
    first_order_tz,
    notes
)
SELECT
    s.product_id,
    s.product_name,
    s.category,
    s.sub_category,
    ROUND(AVG(s.sales), 2) AS avg_sales,
    SUM(s.quantity) AS total_quantity,
    BOOL_OR(s.profit < 0) AS has_loss,
    ARRAY[s.category, s.sub_category] AS tags,
    jsonb_build_object(
        'total_sales', ROUND(SUM(s.sales), 2),
        'total_profit', ROUND(SUM(s.profit), 2),
        'first_order_day', (ARRAY_AGG(p.day_name ORDER BY s.order_date))[1]
    ) AS metrics,
    MIN(s.order_date) AS first_order_date,
    MIN(p.date_actual_time) AS first_order_timestamp,
    MIN(p.date_actual_time) AT TIME ZONE 'Asia/Jakarta' AS first_order_tz,
    NULL AS notes
FROM superstore s
JOIN periode p
    ON s.order_date = p.date_actual
GROUP BY s.product_id, s.product_name, s.category, s.sub_category
ORDER BY SUM(s.sales) DESC
LIMIT 10;

-- 3. Compare text-like types and numeric types.
SELECT
    product_id,
    product_name,
    avg_sales,
    total_quantity
FROM lesson_product_profiles;

-- 4. Work with booleans and UUIDs.
SELECT
    product_id,
    has_loss,
    external_id
FROM lesson_product_profiles;

-- 5. Access array and JSONB values.
SELECT
    product_id,
    tags[1] AS category_tag,
    metrics ->> 'first_order_day' AS first_order_day,
    (metrics ->> 'total_profit')::NUMERIC AS total_profit
FROM lesson_product_profiles;

-- 6. Compare DATE, TIMESTAMP, and TIMESTAMPTZ values.
SELECT
    product_id,
    first_order_date,
    first_order_timestamp,
    first_order_tz,
    first_order_tz AT TIME ZONE 'UTC' AS first_order_utc
FROM lesson_product_profiles;

-- 7. Use COALESCE to handle NULL safely.
SELECT
    product_id,
    COALESCE(notes, 'No notes provided') AS product_notes
FROM lesson_product_profiles;
