-- Exercise 12: Transactions and Savepoints
-- Write your answers below each question.

-- 1. Start a transaction that moves 10.00 profit from row_id 1 to row_id 3,
--    then COMMIT it.

-- 2. Start another transaction, update review_status for row_id 2, create a SAVEPOINT,
--    make a second profit update, then ROLLBACK TO SAVEPOINT and COMMIT.

-- 3. Start a transaction that changes one profit value, then ROLLBACK the whole transaction.

-- 4. After each exercise, run:
--    SELECT * FROM lesson_order_profit_adjustments ORDER BY row_id;
