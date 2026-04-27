-- Lesson 11: Schema Design and Constraints
-- Goal: learn how to model related tables with keys and validation rules.

-- 1. Drop practice tables in dependency order.
DROP TABLE IF EXISTS lesson_enrollments;
DROP TABLE IF EXISTS lesson_courses;
DROP TABLE IF EXISTS lesson_learners;

-- 2. Create parent tables with primary keys, unique constraints, and defaults.
CREATE TABLE lesson_learners (
    learner_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    learner_email TEXT NOT NULL UNIQUE,
    learner_name TEXT NOT NULL,
    learner_region TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lesson_courses (
    course_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_code TEXT NOT NULL UNIQUE,
    course_name TEXT NOT NULL,
    level_name TEXT NOT NULL CHECK (level_name IN ('novice', 'intermediate', 'advanced')),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    is_published BOOLEAN NOT NULL DEFAULT FALSE
);

-- 3. Create a child table with foreign keys and a composite unique rule.
CREATE TABLE lesson_enrollments (
    enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    learner_id INTEGER NOT NULL REFERENCES lesson_learners (learner_id),
    course_id INTEGER NOT NULL REFERENCES lesson_courses (course_id),
    enrolled_on DATE NOT NULL DEFAULT CURRENT_DATE,
    progress_pct NUMERIC(5, 2) NOT NULL DEFAULT 0 CHECK (progress_pct BETWEEN 0 AND 100),
    status_name TEXT NOT NULL DEFAULT 'active' CHECK (status_name IN ('active', 'completed', 'cancelled')),
    UNIQUE (learner_id, course_id)
);

-- 4. Insert sample learners and courses.
INSERT INTO lesson_learners (learner_email, learner_name, learner_region)
VALUES
    ('maya@example.com', 'Maya', 'West'),
    ('ravi@example.com', 'Ravi', 'East'),
    ('lina@example.com', 'Lina', 'Central');

INSERT INTO lesson_courses (course_code, course_name, level_name, price, is_published)
VALUES
    ('PG-101', 'PostgreSQL Foundations', 'novice', 39.00, TRUE),
    ('PG-201', 'Practical Reporting', 'intermediate', 69.00, TRUE),
    ('PG-301', 'Performance Tuning', 'advanced', 99.00, FALSE);

-- 5. Insert child rows that must satisfy foreign keys.
INSERT INTO lesson_enrollments (learner_id, course_id, progress_pct, status_name)
VALUES
    (1, 1, 100, 'completed'),
    (1, 2, 45, 'active'),
    (2, 1, 15, 'active'),
    (3, 2, 0, 'active');

-- 6. Review the normalized result with joins.
SELECT
    l.learner_name,
    l.learner_email,
    c.course_code,
    c.course_name,
    e.progress_pct,
    e.status_name
FROM lesson_enrollments e
JOIN lesson_learners l
    ON e.learner_id = l.learner_id
JOIN lesson_courses c
    ON e.course_id = c.course_id
ORDER BY l.learner_name, c.course_code;

-- 7. Check the table definitions after creation.
\d lesson_learners
\d lesson_courses
\d lesson_enrollments
