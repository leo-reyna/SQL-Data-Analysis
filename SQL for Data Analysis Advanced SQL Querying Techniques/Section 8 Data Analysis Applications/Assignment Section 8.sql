
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


-- Assignment 2: 
-- Create a report of each sudent with their highest grade for the semester
-- as well as which class it was in?
SELECT * FROM students;
SELECT * FROM student_grades;

-- approach 1 with a cte
SELECT 
        s.id,
        s.student_name,
        sg.final_grade,
        sg.class_name,
        ROW_NUMBER() OVER (PARTITION BY s.id ORDER BY sg.final_grade DESC)
FROM    students AS s
LEFT JOIN student_grades AS sg
ON s.id = sg.student_id;

WITH CTE1 AS (
    SELECT 
        s.id,
        s.student_name,
        sg.final_grade,
        sg.class_name,
        ROW_NUMBER() OVER (PARTITION BY s.id ORDER BY sg.final_grade DESC) as row_num
FROM    students AS s
LEFT JOIN student_grades AS sg
ON s.id = sg.student_id
)
SELECT  id,
        student_name,
        final_grade as highest_grade,
        class_name as class_id
FROM    CTE1
WHERE row_num = 1 AND final_grade IS NOT NULL;

-- Approach 2

WITH max_grades AS (
    SELECT student_id,
    MAX(final_grade) as max_grade
    FROM student_grades
    GROUP BY student_id
)
SELECT
    s.id,
    s.student_name,
    mg.max_grade,
    sg.class_name
FROM max_grades as mg
LEFT JOIN students as s
    ON mg.student_id = s.id
LEFT JOIN student_grades AS sg 
    ON sg.student_id = mg.student_id AND sg.final_grade = mg.max_grade
    ORDER by s.id;


-- Video Example:
-- Create a report of each sudent with their highest grade for the semester
-- as well as which class it was in?
-- View the student and student grade tables
SELECT * FROM students;
SELECT * FROM student_grades;


SELECT 
    student_id,
    MAX(final_grade) as max_grade
    FROM student_grades
    GROUP BY student_id;

WITH max_grade_cte as 
(
    SELECT 
    student_id,
    MAX(final_grade) as max_grade
    FROM student_grades
    GROUP BY student_id
)
SELECT 
    st.id,
    st.student_name,
    mg.max_grade,
    stg.class_name
FROM max_grade_cte as mg
LEFT JOIN students as st
    ON mg.student_id = st.id
LEFT JOIN student_grades as stg
    ON st.id = stg.student_id and stg.final_grade = mg.max_grade
    ORDER BY st.id;

-- For each student, return the classes they took and thir final grades
SELECT 
    s.id,
    s.student_name,
    gr.class_name,
    gr.final_grade
FROM students AS s
LEFT JOIN student_grades AS gr
ON s.id = gr.student_id;

-- Return each student's top grade and corresponding class
-- approach 1: group by + join

-- Finding out max grade
SELECT 
    s.id,
    s.student_name,
    MAX(sg.final_grade) as top_grade
FROM students AS s
INNER JOIN student_grades AS sg 
ON s.id = sg.student_id
GROUP BY s.id, s.student_name
ORDER BY s.id;

-- Using it in a CTE
WITH top_grade_cte as
(
SELECT 
    s.id,
    s.student_name,
    MAX(sg.final_grade) as top_grade
FROM students AS s
INNER JOIN student_grades AS sg 
ON s.id = sg.student_id
GROUP BY s.id, s.student_name
ORDER BY s.id
)
SELECT 
    top_grade_cte.id,
    top_grade_cte.student_name,
    top_grade_cte.top_grade,
    sg.class_name
FROM top_grade_cte
LEFT JOIN student_grades as sg
    ON top_grade_cte.id = sg.student_id AND top_grade_cte.top_grade = sg.final_grade;

-- Final Window function query
-- Rank the student garde for each student
SELECT 
    s.id,
    s.student_name,
    sg.class_name,
    sg.final_grade,
    DENSE_RANK() OVER(partition by s.student_name order by sg.final_grade DESC) as grade_rank
FROM students AS s
LEFT JOIN student_grades AS sg 
ON s.id = sg.student_id;

-- Final window function query
WITH cte_top_gr as 
(
    SELECT 
    s.id,
    s.student_name,
    sg.class_name,
    sg.final_grade,
    DENSE_RANK() OVER(partition by s.student_name order by sg.final_grade DESC) as grade_rank
FROM students AS s
LEFT JOIN student_grades AS sg 
ON s.id = sg.student_id
)
SELECT *
FROM cte_top_gr
WHERE grade_rank = 1;



SELECT * FROM students;

SELECT
    sg.department,
    ROUND(AVG(CASE WHEN s.grade_level = 9  THEN sg.final_grade END), 0) AS Freshman,
    ROUND(AVG(CASE WHEN s.grade_level = 10 THEN sg.final_grade END), 0) AS Sophmore,
    ROUND(AVG(CASE WHEN s.grade_level = 11 THEN sg.final_grade END), 0) AS Junior,
    ROUND(AVG(CASE WHEN s.grade_level = 12 THEN sg.final_grade END), 0) AS Senior
FROM student_grades sg
LEFT JOIN students s
    ON sg.student_id = s.id
GROUP BY sg.department
ORDER BY GREATEST(
    Freshman,
    Sophmore,
    Junior,
    Senior
) ASC;

