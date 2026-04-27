-- Solutions 10: Subqueries and EXISTS

-- 1.
SELECT
    order_id,
    sales,
    (
        SELECT AVG(sales)
        FROM superstore
    ) AS overall_avg_sales
FROM superstore
LIMIT 10;

-- 2.
SELECT
    order_id,
    customer_name,
    sales
FROM superstore
WHERE sales > (
    SELECT AVG(sales)
    FROM superstore
)
ORDER BY sales DESC;

-- 3.
SELECT
    s.sub_category,
    s.product_name,
    s.profit
FROM superstore s
WHERE s.profit > (
    SELECT AVG(s2.profit)
    FROM superstore s2
    WHERE s2.sub_category = s.sub_category
)
ORDER BY s.sub_category, s.profit DESC;

-- 4.
SELECT DISTINCT
    s.customer_id,
    s.customer_name
FROM superstore s
WHERE EXISTS (
    SELECT 1
    FROM superstore discounts
    WHERE discounts.customer_id = s.customer_id
      AND discounts.discount > 0.4
)
ORDER BY s.customer_name;

-- 5.
SELECT DISTINCT
    s.product_name
FROM superstore s
WHERE NOT EXISTS (
    SELECT 1
    FROM superstore losses
    WHERE losses.product_name = s.product_name
      AND losses.profit < 0
)
ORDER BY s.product_name;

-- 6.
SELECT
    region_totals.region,
    region_totals.total_sales
FROM (
    SELECT
        region,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY region
) AS region_totals
ORDER BY region_totals.total_sales DESC;
