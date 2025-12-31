
/*
  Assignment 1: 
  There is a student whos showing up multiple times in our student records
  Generate a report of the students and their emails, and exclude duplicate student records
  Use the students table.  
*/

SELECT * FROM students;

-- Identify duplicates
SELECT student_name, count(*) as dup_student
FROM students
GROUP BY student_name;

-- Identify duplicates
WITH cte2 AS (
    SELECT 
        id,
        student_name,
        email,
        ROW_NUMBER() OVER (
            PARTITION BY student_name 
            ORDER BY id
        ) AS rn
    FROM students
)
SELECT *
FROM cte2
WHERE rn = 1;



