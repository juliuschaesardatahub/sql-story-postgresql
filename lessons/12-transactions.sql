-- Lesson 12: Transactions and Savepoints
-- Goal: learn how PostgreSQL groups Superstore-style changes safely.

-- 1. Create a small transaction practice table from Superstore rows.
DROP TABLE IF EXISTS lesson_order_profit_adjustments;

CREATE TABLE lesson_order_profit_adjustments (
    adjustment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    row_id INTEGER NOT NULL UNIQUE,
    order_id VARCHAR(50) NOT NULL,
    product_name TEXT NOT NULL,
    sales NUMERIC(12, 4) NOT NULL CHECK (sales >= 0),
    profit NUMERIC(12, 4) NOT NULL,
    review_status TEXT NOT NULL DEFAULT 'open',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO lesson_order_profit_adjustments (
    row_id,
    order_id,
    product_name,
    sales,
    profit
)
SELECT
    row_id,
    order_id,
    product_name,
    sales,
    profit
FROM superstore
WHERE row_id IN (1, 2, 3);

-- 2. Review the starting values.
SELECT *
FROM lesson_order_profit_adjustments
ORDER BY row_id;

-- 3. Move a profit adjustment safely inside one transaction.
BEGIN;

UPDATE lesson_order_profit_adjustments
SET
    profit = profit - 25.00,
    updated_at = CURRENT_TIMESTAMP
WHERE row_id = 1;

UPDATE lesson_order_profit_adjustments
SET
    profit = profit + 25.00,
    updated_at = CURRENT_TIMESTAMP
WHERE row_id = 2;

COMMIT;

-- 4. Use a savepoint so part of a transaction can be undone.
BEGIN;

UPDATE lesson_order_profit_adjustments
SET review_status = 'reviewing'
WHERE row_id = 2;

SAVEPOINT before_risky_change;

UPDATE lesson_order_profit_adjustments
SET profit = profit - 10000.00
WHERE row_id = 3;

ROLLBACK TO SAVEPOINT before_risky_change;

UPDATE lesson_order_profit_adjustments
SET
    review_status = 'approved',
    updated_at = CURRENT_TIMESTAMP
WHERE row_id = 3;

COMMIT;

-- 5. Verify final values.
SELECT *
FROM lesson_order_profit_adjustments
ORDER BY row_id;

-- 6. Example rollback block for experimentation.
BEGIN;

UPDATE lesson_order_profit_adjustments
SET profit = profit + 9999.00
WHERE row_id = 1;

ROLLBACK;

-- 7. Confirm the rollback prevented the last change.
SELECT *
FROM lesson_order_profit_adjustments
ORDER BY row_id;
