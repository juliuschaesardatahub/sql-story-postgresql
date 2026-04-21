-- Exercise 05: DDL, DML, and Constraints
-- Write your answers below each question.

-- 1. Drop and recreate a practice table named product_discount_targets with:
--    product_id as primary key, product_name not null, target_discount numeric(4,2),
--    category, active_flag default true, created_at default current timestamp.

-- 2. Insert 10 distinct products from superstore into product_discount_targets
--    with a default target_discount of 0.15.

-- 3. Alter the table to add a notes column.

-- 4. Update the notes column to 'Review furniture pricing'
--    for rows where category = 'Furniture'.

-- 5. Delete rows where category = 'Office Supplies'.

-- 6. Upsert one row for product_id = 'FUR-BO-10001798'
--    with product_name = 'Bush Somerset Collection Bookcase',
--    target_discount = 0.20, category = 'Furniture',
--    and notes = 'Updated by upsert'.

-- 7. Return all rows from product_discount_targets ordered by category and product_name.
