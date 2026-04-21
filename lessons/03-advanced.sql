-- Lesson 03: Advanced SQL
-- Goal: learn CTEs, window functions, ranking, and running totals.

-- 1. Monthly sales with a running total.
WITH monthly_sales AS (
    SELECT
        p.year_actual,
        p.month_actual,
        p.month_name,
        SUM(s.sales) AS total_sales
    FROM superstore s
    JOIN periode p
        ON s.order_date = p.date_actual
    GROUP BY p.year_actual, p.month_actual, p.month_name
)
SELECT
    year_actual,
    month_actual,
    month_name,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY year_actual, month_actual
    ) AS running_sales
FROM monthly_sales
ORDER BY year_actual, month_actual;

-- 2. Profit ranking by category.
WITH product_profit AS (
    SELECT
        category,
        product_name,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY category, product_name
)
SELECT
    category,
    product_name,
    total_profit,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY total_profit DESC
    ) AS profit_rank
FROM product_profit
ORDER BY category, profit_rank, product_name;

-- 3. Top-selling month in each year.
WITH monthly_sales AS (
    SELECT
        p.year_actual,
        p.month_actual,
        p.month_name,
        SUM(s.sales) AS total_sales
    FROM superstore s
    JOIN periode p
        ON s.order_date = p.date_actual
    GROUP BY p.year_actual, p.month_actual, p.month_name
),
ranked_months AS (
    SELECT
        year_actual,
        month_actual,
        month_name,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY year_actual
            ORDER BY total_sales DESC
        ) AS rn
    FROM monthly_sales
)
SELECT
    year_actual,
    month_name,
    total_sales
FROM ranked_months
WHERE rn = 1
ORDER BY year_actual;

-- 4. Previous order date by customer.
SELECT
    customer_id,
    customer_name,
    order_date,
    sales,
    LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM superstore
ORDER BY customer_id, order_date;

-- 5. High-discount, low-profit products.
SELECT
    sub_category,
    product_name,
    AVG(discount) AS avg_discount,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY sub_category, product_name
HAVING AVG(discount) > 0.3
   AND SUM(profit) < 0
ORDER BY avg_discount DESC, total_profit;
