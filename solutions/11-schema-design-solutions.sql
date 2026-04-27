-- Solutions 11: Schema Design and Constraints

-- 1.
INSERT INTO lesson_dim_customers (customer_id, customer_name, segment, region)
VALUES ('TEST-CUST-001', 'Practice Customer', 'Consumer', 'West');

-- 2.
INSERT INTO lesson_dim_products (product_id, product_name, category, sub_category)
VALUES ('TEST-PROD-001', 'Practice Product', 'Office Supplies', 'Paper');

-- 3.
INSERT INTO lesson_fact_order_items (
    row_id,
    order_id,
    customer_id,
    product_id,
    order_date,
    sales,
    quantity,
    discount,
    profit
)
VALUES (
    999999,
    'TEST-ORDER-001',
    'TEST-CUST-001',
    'TEST-PROD-001',
    DATE '2017-01-01',
    100.00,
    2,
    0.10,
    20.00
);

-- 4.
SELECT
    f.order_id,
    c.customer_name,
    p.product_name,
    f.sales,
    f.profit
FROM lesson_fact_order_items f
JOIN lesson_dim_customers c
    ON f.customer_id = c.customer_id
JOIN lesson_dim_products p
    ON f.product_id = p.product_id
ORDER BY f.order_id;
