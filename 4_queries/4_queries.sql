-- SELECT count(assistance_requests.*) as total_assistances, teachers.name as name
-- FROM assistance_requests
-- JOIN teachers ON teachers.id = teacher_id
-- WHERE teachers.name = 'Waylon Boehm'
-- GROUP BY teachers.name;

-- SELECT count(assistance_requests.*) as total_assistances, students.name as name
-- FROM assistance_requests
-- JOIN students ON students.id = student_id
-- WHERE students.name = 'Elliot Dickinson'
-- GROUP BY name;

-- SELECT teachers.name as teacher, students.name as student, assignments.name as assignment, (assistance_requests.completed_at - assistance_requests.started_at) as duration
-- FROM assistance_requests
-- JOIN teachers ON teachers.id = teacher_id
-- JOIN students ON students.id = student_id
-- JOIN assignments ON assignments.id = assignment_id
-- ORDER BY duration;

-- SELECT avg(assistance_requests.completed_at - assistance_requests.started_at)
-- FROM assistance_requests

-- SELECT cohorts.name as name, avg(assistance_requests.completed_at - assistance_requests.started_at) as average_assignment_time
-- FROM assistance_requests
-- JOIN students ON students.id = student_id
-- JOIN cohorts ON cohorts.id = cohort_id
-- GROUP BY cohorts.name
-- ORDER BY average_assignment_time DESC

-- SELECT cohorts.name, avg(completed_at - started_at) as average_assistance_time
-- FROM assistance_requests 
-- JOIN students ON students.id = assistance_requests.student_id
-- JOIN cohorts ON cohorts.id = cohort_id
-- GROUP BY cohorts.name
-- ORDER BY average_assistance_time DESC
-- LIMIT 1;

-- SELECT avg(started_at - created_at) as average_wait_time
-- FROM assistance_requests

-- SELECT cohorts.name as cohort, sum(completed_at - started_at) as total_duration
-- FROM assistance_requests
-- JOIN students ON student_id = students.id
-- JOIN cohorts ON cohorts.id = cohort_id
-- GROUP BY cohorts.name
-- ORDER BY total_duration

-- SELECT avg(total_duration) as average_total_duration
-- FROM (SELECT cohorts.name as cohort, sum(completed_at - started_at) as total_duration
-- FROM assistance_requests
-- JOIN students ON student_id = students.id
-- JOIN cohorts ON cohorts.id = cohort_id
-- GROUP BY cohorts.name
-- ORDER BY total_duration) as x

-- SELECT assignments.id, name, day, chapter, count(assistance_requests) as total_requests
-- FROM assignments
-- JOIN assistance_requests ON assignments.id = assignment_id
-- GROUP BY assignments.id
-- ORDER BY total_requests DESC;

-- SELECT day as day, count(*) as number_of_assignments, sum(duration) as duration
-- FROM assignments
-- GROUP BY day
-- ORDER BY day

-- SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort
-- FROM teachers
-- JOIN assistance_requests ON teacher_id = teachers.id
-- JOIN students ON student_id = students.id
-- JOIN cohorts ON cohort_id = cohorts.id
-- WHERE cohorts.name = 'JUL02'
-- ORDER BY teacher;

SELECT teachers.name as teacher, cohorts.name as cohort, count(assistance_requests.*) as total_assistances
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teacher;