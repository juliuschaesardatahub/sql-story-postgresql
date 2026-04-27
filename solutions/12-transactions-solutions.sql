-- Solutions 12: Transactions and Savepoints

-- 1.
BEGIN;

UPDATE lesson_order_profit_adjustments
SET profit = profit - 10.00
WHERE row_id = 1;

UPDATE lesson_order_profit_adjustments
SET profit = profit + 10.00
WHERE row_id = 3;

COMMIT;

-- 2.
BEGIN;

UPDATE lesson_order_profit_adjustments
SET review_status = 'reviewing'
WHERE row_id = 2;

SAVEPOINT after_status_update;

UPDATE lesson_order_profit_adjustments
SET profit = profit - 200.00
WHERE row_id = 2;

ROLLBACK TO SAVEPOINT after_status_update;

COMMIT;

-- 3.
BEGIN;

UPDATE lesson_order_profit_adjustments
SET profit = profit + 999.00
WHERE row_id = 3;

ROLLBACK;

-- 4.
SELECT *
FROM lesson_order_profit_adjustments
ORDER BY row_id;
