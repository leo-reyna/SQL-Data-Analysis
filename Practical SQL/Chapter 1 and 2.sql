-- POSTGRESQL 18.00
-- Creating the database
-- CREATE DATABASE analysis;


-- Creating the teachers table
 CREATE TABLE teachers(
	id bigserial,
	first_name varchar(25),
	last_name varchar(50),
	school varchar(50),
	hire_date date,
	salary numeric
 );

 INSERT INTO teachers(first_name, last_name, school, hire_date, salary)
 VALUES	('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', '36200'),
		('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', '65000'),
		('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', '43500'),
		('Samatha', 'Bush', 'Myers Middle School', '2011-10-30', '36200'),
		('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', '43500'),
		('Joe', 'Dirt', 'F.D. Roosevelt HS', '2010-05-22', '45300'),
		('Kathleen', 'Rousch', 'F.D. Roosevelt HS', '2010-10-22', '38500');



SELECT * FROM teachers;

UPDATE teachers
SET first_name = 'Samantha'
WHERE first_name = 'Samatha';

SELECT DISTINCT school, salary FROM teachers;

SELECT 
		 first_name, 
		 last_name, 
		 salary
FROM	 teachers
ORDER BY salary DESC; 


SELECT 
		 first_name || ' ' || last_name AS full_name,
		 school,
		 hire_date
FROM	 teachers
ORDER BY school ASC, hire_date DESC; 


SELECT 
		first_name || ' ' || last_name AS full_name,
		school,
		hire_date
FROM	teachers
WHERE 	school = 'Myers Middle School';


SELECT 
		 first_name,
		 school,
		 hire_date
FROM	 teachers
WHERE first_name = 'Janet'; 

SELECT 
		first_name,
		last_name,
		salary
FROM 	teachers
WHERE SALARY >= 40000;

SELECT 
		first_name,
		last_name,
		salary
FROM 	teachers
WHERE SALARY BETWEEN 10000 AND 40000;

SELECT 
		first_name,
		last_name,
		salary
FROM 	teachers
WHERE first_name LIKE '%a';

SELECT 
		first_name,
		last_name,
		salary
FROM 	teachers
WHERE first_name ILIKE 'sam%';

SELECT 
		first_name,
		last_name,
		salary
FROM 	teachers
WHERE first_name LIKE '_amantha';


SELECT 
		first_name,
		last_name,
		salary
FROM 	teachers
WHERE first_name ILIKE 'sam%'
		OR first_name ILIKE 'k%'
ORDER BY first_name;


SELECT *
FROM teachers
WHERE school = 'F.D. Roosevelt HS' AND (salary < 30000 or salary > 40000);


SELECT  
		first_name || ' ' || last_name AS full_name,
		last_name,
		school
FROM 	teachers
ORDER BY last_name ASC, school DESC;

SELECT  
		first_name,
		last_name,
		salary,
		school
FROM 	teachers
WHERE 	first_name ILIKE 's%' AND salary > 40000;

SELECT 
		first_name,
		last_name,
		salary,
		hire_date,
		school
FROM 	teachers
WHERE 	hire_date < '2010-01-01'
	AND salary > 40000;

SELECT 
		first_name,
		last_name,
		salary,
		hire_date,
		school
FROM 	teachers
WHERE 	hire_date < '2010-01-01'
	AND salary > 40000
ORDER BY salary DESC;