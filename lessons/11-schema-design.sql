-- Lesson 11: Schema Design and Constraints
-- Goal: learn how to model Superstore data into related tables with keys.

-- 1. Drop practice tables in dependency order.
DROP TABLE IF EXISTS lesson_fact_order_items;
DROP TABLE IF EXISTS lesson_dim_products;
DROP TABLE IF EXISTS lesson_dim_customers;

-- 2. Create parent tables with primary keys, unique constraints, and defaults.
CREATE TABLE lesson_dim_customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name TEXT NOT NULL,
    segment TEXT NOT NULL CHECK (segment IN ('Consumer', 'Corporate', 'Home Office')),
    region TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lesson_dim_products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    sub_category TEXT NOT NULL
);

-- 3. Create a child table with foreign keys and validation rules.
CREATE TABLE lesson_fact_order_items (
    row_id INTEGER PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,
    customer_id VARCHAR(50) NOT NULL REFERENCES lesson_dim_customers (customer_id),
    product_id VARCHAR(50) NOT NULL REFERENCES lesson_dim_products (product_id),
    order_date DATE NOT NULL,
    sales NUMERIC(12, 4) NOT NULL CHECK (sales >= 0),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    discount NUMERIC(4, 2) NOT NULL CHECK (discount BETWEEN 0 AND 1),
    profit NUMERIC(12, 4) NOT NULL
);

-- 4. Insert sample dimension rows from superstore.
INSERT INTO lesson_dim_customers (customer_id, customer_name, segment, region)
SELECT DISTINCT ON (customer_id)
    customer_id,
    customer_name,
    segment,
    region
FROM superstore
ORDER BY customer_id
LIMIT 25;

INSERT INTO lesson_dim_products (product_id, product_name, category, sub_category)
SELECT DISTINCT ON (product_id)
    product_id,
    product_name,
    category,
    sub_category
FROM superstore
ORDER BY product_id
LIMIT 40;

-- 5. Insert fact rows that must satisfy foreign keys.
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
SELECT
    s.row_id,
    s.order_id,
    s.customer_id,
    s.product_id,
    s.order_date,
    s.sales,
    s.quantity,
    s.discount,
    s.profit
FROM superstore s
JOIN lesson_dim_customers c
    ON s.customer_id = c.customer_id
JOIN lesson_dim_products p
    ON s.product_id = p.product_id
ORDER BY s.row_id
LIMIT 50;

-- 6. Review the normalized result with joins.
SELECT
    f.order_id,
    c.customer_name,
    c.region,
    p.category,
    p.product_name,
    f.sales,
    f.profit
FROM lesson_fact_order_items f
JOIN lesson_dim_customers c
    ON f.customer_id = c.customer_id
JOIN lesson_dim_products p
    ON f.product_id = p.product_id
ORDER BY f.order_date, f.order_id;
