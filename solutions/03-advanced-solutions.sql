-- Solutions 03: Advanced SQL

-- 1.
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
    month_name,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY year_actual, month_actual
    ) AS running_sales
FROM monthly_sales
ORDER BY year_actual, month_actual;

-- 2.
WITH customer_sales AS (
    SELECT
        region,
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY region, customer_id, customer_name
)
SELECT
    region,
    customer_name,
    total_sales,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM customer_sales
ORDER BY region, sales_rank, customer_name;

-- 3.
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
    total_profit
FROM (
    SELECT
        category,
        product_name,
        total_profit,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_profit DESC
        ) AS rn
    FROM product_profit
) ranked
WHERE rn <= 3
ORDER BY category, total_profit DESC;

-- 4.
SELECT
    customer_id,
    customer_name,
    order_date,
    LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM superstore
ORDER BY customer_id, order_date;

-- 5.
SELECT
    region,
    SUM(sales) AS total_sales,
    ROUND(
        100.0 * SUM(sales) / SUM(SUM(sales)) OVER (),
        2
    ) AS pct_of_total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- 6.
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

-- 7.
SELECT
    CASE
        WHEN p.weekend_flag = 1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(s.sales) AS total_sales,
    SUM(s.profit) AS total_profit
FROM superstore s
JOIN periode p
    ON s.order_date = p.date_actual
GROUP BY
    CASE
        WHEN p.weekend_flag = 1 THEN 'Weekend'
        ELSE 'Weekday'
    END
ORDER BY day_type;

-- 8.
WITH monthly_profit AS (
    SELECT
        s.region,
        p.year_actual,
        p.month_actual,
        p.month_name,
        SUM(s.profit) AS total_profit
    FROM superstore s
    JOIN periode p
        ON s.order_date = p.date_actual
    GROUP BY s.region, p.year_actual, p.month_actual, p.month_name
),
ranked_profit AS (
    SELECT
        region,
        year_actual,
        month_actual,
        month_name,
        total_profit,
        DENSE_RANK() OVER (
            PARTITION BY region
            ORDER BY total_profit DESC
        ) AS profit_rank
    FROM monthly_profit
)
SELECT
    region,
    year_actual,
    month_name,
    total_profit,
    profit_rank
FROM ranked_profit
WHERE profit_rank = 1
ORDER BY region, year_actual, month_actual;

-- 9.
WITH customer_summary AS (
    SELECT
        customer_id,
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date,
        MAX(order_date) - MIN(order_date) AS active_days
    FROM superstore
    GROUP BY customer_id, customer_name
)
SELECT
    customer_id,
    customer_name,
    total_orders,
    total_sales,
    total_profit,
    first_order_date,
    last_order_date,
    active_days,
    ROUND(
        active_days::numeric / NULLIF(total_orders - 1, 0),
        2
    ) AS avg_days_between_orders
FROM customer_summary
ORDER BY total_sales DESC, customer_name;

-- 10.
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
sales_with_previous AS (
    SELECT
        year_actual,
        month_actual,
        month_name,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY year_actual, month_actual
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    year_actual,
    month_name,
    total_sales,
    previous_month_sales,
    total_sales - previous_month_sales AS sales_difference,
    ROUND(
        100.0 * (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0),
        2
    ) AS growth_percentage
FROM sales_with_previous
ORDER BY year_actual, month_actual;
