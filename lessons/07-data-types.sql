-- Lesson 07: PostgreSQL Data Types and NULL Handling
-- Goal: learn practical PostgreSQL types and how NULL affects queries.

-- 1. Create a sandbox table with common PostgreSQL data types.
DROP TABLE IF EXISTS lesson_data_types;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE lesson_data_types (
    lesson_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lesson_code VARCHAR(20) NOT NULL,
    lesson_name TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    seats_available INTEGER NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    external_id UUID DEFAULT gen_random_uuid(),
    tags TEXT[],
    metadata JSONB,
    starts_on DATE NOT NULL,
    starts_at TIMESTAMP NOT NULL,
    starts_at_tz TIMESTAMPTZ NOT NULL,
    notes TEXT
);

-- 2. Insert sample rows.
INSERT INTO lesson_data_types (
    lesson_code,
    lesson_name,
    price,
    seats_available,
    is_active,
    tags,
    metadata,
    starts_on,
    starts_at,
    starts_at_tz,
    notes
) VALUES
(
    'SQL-101',
    'PostgreSQL Basics',
    49.99,
    30,
    TRUE,
    ARRAY['sql', 'postgres', 'beginner'],
    '{"level":"novice","duration_hours":4}'::jsonb,
    DATE '2026-05-01',
    TIMESTAMP '2026-05-01 09:00:00',
    TIMESTAMPTZ '2026-05-01 09:00:00+07',
    NULL
),
(
    'SQL-201',
    'Analytics with PostgreSQL',
    79.50,
    18,
    TRUE,
    ARRAY['analytics', 'window-functions'],
    '{"level":"advanced","duration_hours":6}'::jsonb,
    DATE '2026-05-08',
    TIMESTAMP '2026-05-08 13:30:00',
    TIMESTAMPTZ '2026-05-08 13:30:00+07',
    'Bring your own examples'
);

-- 3. Compare text-like types and numeric types.
SELECT
    lesson_code,
    lesson_name,
    price,
    seats_available
FROM lesson_data_types;

-- 4. Work with booleans and UUIDs.
SELECT
    lesson_code,
    is_active,
    external_id
FROM lesson_data_types;

-- 5. Access array and JSONB values.
SELECT
    lesson_code,
    tags[1] AS first_tag,
    metadata ->> 'level' AS level_name,
    (metadata ->> 'duration_hours')::INTEGER AS duration_hours
FROM lesson_data_types;

-- 6. Compare DATE, TIMESTAMP, and TIMESTAMPTZ values.
SELECT
    lesson_code,
    starts_on,
    starts_at,
    starts_at_tz,
    starts_at_tz AT TIME ZONE 'UTC' AS starts_at_utc
FROM lesson_data_types;

-- 7. Use COALESCE to handle NULL safely.
SELECT
    lesson_code,
    COALESCE(notes, 'No notes provided') AS lesson_notes
FROM lesson_data_types;
