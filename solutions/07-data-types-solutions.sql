-- Solutions 07: Data Types and NULL Handling

-- 1.
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
) VALUES (
    'SQL-301',
    'JSONB in PostgreSQL',
    89.00,
    20,
    TRUE,
    ARRAY['jsonb', 'postgres'],
    '{"level":"advanced","duration_hours":5}'::jsonb,
    DATE '2026-06-01',
    TIMESTAMP '2026-06-01 10:00:00',
    TIMESTAMPTZ '2026-06-01 10:00:00+07',
    NULL
);

-- 2.
SELECT
    lesson_code,
    lesson_name,
    metadata ->> 'level' AS level_name
FROM lesson_data_types;

-- 3.
SELECT
    lesson_code,
    lesson_name,
    seats_available
FROM lesson_data_types
WHERE is_active = TRUE
  AND seats_available > 10;

-- 4.
SELECT
    lesson_code,
    tags[2] AS second_tag
FROM lesson_data_types;

-- 5.
SELECT
    lesson_code,
    starts_at_tz AT TIME ZONE 'UTC' AS starts_at_utc
FROM lesson_data_types;

-- 6.
SELECT
    lesson_code,
    COALESCE(notes, 'No notes') AS lesson_notes
FROM lesson_data_types;
