-- Solutions 12: Transactions and Savepoints

-- 1.
BEGIN;

UPDATE lesson_wallets
SET balance = balance - 50.00
WHERE owner_name = 'Asha';

UPDATE lesson_wallets
SET balance = balance + 50.00
WHERE owner_name = 'Cora';

COMMIT;

-- 2.
BEGIN;

UPDATE lesson_wallets
SET balance = balance + 20.00
WHERE owner_name = 'Bimo';

SAVEPOINT after_bonus;

UPDATE lesson_wallets
SET balance = balance - 200.00
WHERE owner_name = 'Bimo';

ROLLBACK TO SAVEPOINT after_bonus;

COMMIT;

-- 3.
BEGIN;

UPDATE lesson_wallets
SET balance = balance + 999.00
WHERE owner_name = 'Cora';

ROLLBACK;

-- 4.
SELECT *
FROM lesson_wallets
ORDER BY wallet_id;

-- 5.
-- A transaction keeps related changes atomic, so either all steps succeed together
-- or all of them are undone to avoid inconsistent balances.
