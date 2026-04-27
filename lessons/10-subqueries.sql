-- Lesson 10: Subqueries and EXISTS
-- Goal: learn scalar subqueries, correlated subqueries, and EXISTS patterns.

-- 1. Scalar subquery: compare each order to the overall average sale.
SELECT
    order_id,
    customer_name,
    sales,
    (
        SELECT AVG(sales)
        FROM superstore
    ) AS overall_avg_sales
FROM superstore
ORDER BY sales DESC
LIMIT 10;

-- 2. Filter rows above the overall average using a subquery.
SELECT
    order_id,
    customer_name,
    sales
FROM superstore
WHERE sales > (
    SELECT AVG(sales)
    FROM superstore
)
ORDER BY sales DESC
LIMIT 15;

-- 3. Correlated subquery: compare each product to its category average.
SELECT
    s.category,
    s.product_name,
    s.sales
FROM superstore s
WHERE s.sales > (
    SELECT AVG(s2.sales)
    FROM superstore s2
    WHERE s2.category = s.category
)
ORDER BY s.category, s.sales DESC
LIMIT 20;

-- 4. EXISTS: customers with at least one loss-making order.
SELECT DISTINCT
    s.customer_id,
    s.customer_name
FROM superstore s
WHERE EXISTS (
    SELECT 1
    FROM superstore loss_rows
    WHERE loss_rows.customer_id = s.customer_id
      AND loss_rows.profit < 0
)
ORDER BY s.customer_name
LIMIT 20;

-- 5. NOT EXISTS: products that never produced a loss.
SELECT DISTINCT
    s.product_name
FROM superstore s
WHERE NOT EXISTS (
    SELECT 1
    FROM superstore bad_rows
    WHERE bad_rows.product_name = s.product_name
      AND bad_rows.profit < 0
)
ORDER BY s.product_name
LIMIT 20;

-- 6. Derived table subquery: rank categories by total sales.
SELECT
    category_totals.category,
    category_totals.total_sales
FROM (
    SELECT
        category,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY category
) AS category_totals
ORDER BY category_totals.total_sales DESC;

-- 7. Compare a join-based rewrite for readability.
SELECT
    s.customer_id,
    s.customer_name,
    customer_profit.total_profit
FROM (
    SELECT
        customer_id,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY customer_id
) AS customer_profit
JOIN superstore s
    ON s.customer_id = customer_profit.customer_id
WHERE customer_profit.total_profit > 1000
GROUP BY s.customer_id, s.customer_name, customer_profit.total_profit
ORDER BY customer_profit.total_profit DESC;
