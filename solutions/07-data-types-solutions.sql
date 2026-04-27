-- Solutions 07: Data Types and NULL Handling

-- 1.
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
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(AVG(sales), 2) AS avg_sales,
    SUM(quantity) AS total_quantity,
    BOOL_OR(profit < 0) AS has_loss,
    ARRAY[category, sub_category] AS tags,
    jsonb_build_object(
        'total_sales', ROUND(SUM(sales), 2),
        'total_profit', ROUND(SUM(profit), 2)
    ) AS metrics,
    MIN(order_date) AS first_order_date,
    MIN(order_date)::TIMESTAMP AS first_order_timestamp,
    MIN(order_date)::TIMESTAMP AT TIME ZONE 'Asia/Jakarta' AS first_order_tz,
    NULL AS notes
FROM superstore
WHERE product_id = 'FUR-BO-10001798'
GROUP BY product_id, product_name, category, sub_category;

-- 2.
SELECT
    product_id,
    product_name,
    metrics ->> 'total_profit' AS total_profit
FROM lesson_product_profiles;

-- 3.
SELECT
    product_id,
    product_name,
    total_quantity
FROM lesson_product_profiles
WHERE has_loss = TRUE
  AND total_quantity > 10;

-- 4.
SELECT
    product_id,
    tags[2] AS second_tag
FROM lesson_product_profiles;

-- 5.
SELECT
    product_id,
    first_order_tz AT TIME ZONE 'UTC' AS first_order_utc
FROM lesson_product_profiles;

-- 6.
SELECT
    product_id,
    COALESCE(notes, 'No notes') AS product_notes
FROM lesson_product_profiles;
