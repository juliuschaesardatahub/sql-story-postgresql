-- Lesson 12: Transactions and Savepoints
-- Goal: learn how PostgreSQL groups changes safely with BEGIN, COMMIT, and ROLLBACK.

-- 1. Create a small transaction practice table.
DROP TABLE IF EXISTS lesson_wallets;

CREATE TABLE lesson_wallets (
    wallet_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    owner_name TEXT NOT NULL,
    balance NUMERIC(10, 2) NOT NULL CHECK (balance >= 0)
);

INSERT INTO lesson_wallets (owner_name, balance)
VALUES
    ('Asha', 500.00),
    ('Bimo', 300.00),
    ('Cora', 150.00);

-- 2. Review the starting balances.
SELECT *
FROM lesson_wallets
ORDER BY wallet_id;

-- 3. Transfer funds safely inside one transaction.
BEGIN;

UPDATE lesson_wallets
SET balance = balance - 75.00
WHERE owner_name = 'Asha';

UPDATE lesson_wallets
SET balance = balance + 75.00
WHERE owner_name = 'Bimo';

COMMIT;

-- 4. Use a savepoint so part of a transaction can be undone.
BEGIN;

UPDATE lesson_wallets
SET balance = balance - 25.00
WHERE owner_name = 'Bimo';

SAVEPOINT before_risky_change;

UPDATE lesson_wallets
SET balance = balance - 500.00
WHERE owner_name = 'Cora';

ROLLBACK TO SAVEPOINT before_risky_change;

UPDATE lesson_wallets
SET balance = balance + 25.00
WHERE owner_name = 'Cora';

COMMIT;

-- 5. Verify final balances.
SELECT *
FROM lesson_wallets
ORDER BY wallet_id;

-- 6. Example rollback block for experimentation.
BEGIN;

UPDATE lesson_wallets
SET balance = balance + 1000.00
WHERE owner_name = 'Asha';

ROLLBACK;

-- 7. Confirm the rollback prevented the last change.
SELECT *
FROM lesson_wallets
ORDER BY wallet_id;
