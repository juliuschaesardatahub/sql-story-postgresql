-- Solutions 11: Schema Design and Constraints

-- 1.
INSERT INTO lesson_learners (learner_email, learner_name, learner_region)
VALUES ('omar@example.com', 'Omar', 'South');

-- 2.
INSERT INTO lesson_courses (course_code, course_name, level_name, price, is_published)
VALUES ('PG-401', 'Advanced Query Design', 'advanced', 129.00, TRUE);

-- 3.
INSERT INTO lesson_enrollments (learner_id, course_id, progress_pct, status_name)
VALUES (4, 4, 5, 'active');

-- 4.
SELECT
    l.learner_name,
    c.course_code,
    c.course_name,
    e.status_name
FROM lesson_enrollments e
JOIN lesson_learners l
    ON e.learner_id = l.learner_id
JOIN lesson_courses c
    ON e.course_id = c.course_id
ORDER BY l.learner_name, c.course_code;

-- 5.
-- It prevents the same learner from being enrolled in the same course more than once.

-- 6.
\d lesson_enrollments
