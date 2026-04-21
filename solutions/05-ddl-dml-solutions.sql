-- Solutions 05: DDL, DML, and Constraints

-- 1.
DROP TABLE IF EXISTS product_discount_targets;

CREATE TABLE product_discount_targets (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    target_discount NUMERIC(4, 2) CHECK (target_discount >= 0),
    category VARCHAR(50),
    active_flag BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.
INSERT INTO product_discount_targets (product_id, product_name, target_discount, category)
SELECT DISTINCT
    product_id,
    product_name,
    0.15 AS target_discount,
    category
FROM superstore
ORDER BY product_id
LIMIT 10;

-- 3.
ALTER TABLE product_discount_targets
ADD COLUMN notes VARCHAR(255);

-- 4.
UPDATE product_discount_targets
SET notes = 'Review furniture pricing'
WHERE category = 'Furniture';

-- 5.
DELETE FROM product_discount_targets
WHERE category = 'Office Supplies';

-- 6.
INSERT INTO product_discount_targets (
    product_id,
    product_name,
    target_discount,
    category,
    notes
)
VALUES (
    'FUR-BO-10001798',
    'Bush Somerset Collection Bookcase',
    0.20,
    'Furniture',
    'Updated by upsert'
)
ON CONFLICT (product_id)
DO UPDATE SET
    product_name = EXCLUDED.product_name,
    target_discount = EXCLUDED.target_discount,
    category = EXCLUDED.category,
    notes = EXCLUDED.notes;

-- 7.
SELECT *
FROM product_discount_targets
ORDER BY category, product_name;
