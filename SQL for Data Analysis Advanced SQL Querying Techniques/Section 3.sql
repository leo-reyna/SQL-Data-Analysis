-- Connecting to the database
USE maven_advanced_sql;

SELECT *
FROM students;

SELECT grade_level, AVG(gpa) AS avg_gpa
FROM students
WHERE school_lunch = 'Yes'
GROUP BY grade_level
ORDER BY grade_level;

-- this filters the output from above
SELECT grade_level, AVG(gpa) AS avg_gpa
FROM students
WHERE school_lunch = 'Yes'
GROUP BY grade_level -- requires an calculation, in this example it is using the avg function
HAVING grade_level > 3.00 -- filters the grouped data
ORDER BY grade_level;

SELECT count(DISTINCT grade_level)
FROM students;

SELECT max(gpa), min(gpa)
FROM students;

-- range
SELECT max(gpa) - min(gpa) as gpa_range
FROM students;

-- MULTIPLE CRITERIA WHERE
SELECT *
FROM students
WHERE grade_level < 12 AND school_lunch = 'Yes';

-- IN 
SELECT *
FROM students
WHERE grade_level in (9, 10, 11)
ORDER BY grade_level;

-- IS NULL
SELECT *
FROM students
WHERE email IS NULL;

SELECT *
FROM students
WHERE email IS NOT NULL;

-- LIKE
SELECT *
FROM students
WHERE email LIKE '%.edu';

-- ORDER BY
SELECT *
FROM students
ORDER BY gpa desc;

-- LIMIT
SELECT *
FROM students
ORDER BY gpa desc
LIMIT 5;

-- CASE
SELECT student_name, grade_level,
CASE WHEN grade_level = 9 THEN 'Refreshman'
WHEN grade_level = 10 THEN 'Sophmore'
WHEN grade_level = 11 THEN 'Junior'
ELSE 'Senior'
END AS 'type_grade'
FROM students;