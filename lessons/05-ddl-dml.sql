-- Lesson 05: DDL, DML, and Constraints
-- Goal: learn CREATE, ALTER, INSERT, UPDATE, DELETE, and UPSERT patterns.

-- 1. Create a practice table based on customer summaries.
DROP TABLE IF EXISTS customer_sales_targets;

CREATE TABLE customer_sales_targets (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    target_sales NUMERIC(12, 2) NOT NULL CHECK (target_sales >= 0),
    region VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Insert sample rows from real data.
INSERT INTO customer_sales_targets (customer_id, customer_name, target_sales, region)
SELECT DISTINCT
    customer_id,
    customer_name,
    5000.00 AS target_sales,
    region
FROM superstore
ORDER BY customer_id
LIMIT 10;

-- 3. Alter the table.
ALTER TABLE customer_sales_targets
ADD COLUMN notes VARCHAR(255);

-- 4. Update rows.
UPDATE customer_sales_targets
SET notes = 'Priority account'
WHERE region = 'West';

-- 5. Delete selected practice rows.
DELETE FROM customer_sales_targets
WHERE region = 'South';

-- 6. Upsert example.
INSERT INTO customer_sales_targets (customer_id, customer_name, target_sales, region, notes)
VALUES ('CG-12520', 'Claire Gute', 12000.00, 'South', 'Updated by upsert')
ON CONFLICT (customer_id)
DO UPDATE SET
    target_sales = EXCLUDED.target_sales,
    region = EXCLUDED.region,
    notes = EXCLUDED.notes;

-- 7. Review results.
SELECT *
FROM customer_sales_targets
ORDER BY customer_id;
