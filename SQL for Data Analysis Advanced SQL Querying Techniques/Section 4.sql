-- Section 4
-- Connect to database (MySQL)
use maven_advanced_sql;

-- 1. Basic joins
SELECT * FROM happiness_scores;
SELECT * FROM country_stats;

SELECT * FROM happiness_scores 
JOIN country_stats;

SELECT * 
FROM happiness_scores AS hs
INNER JOIN country_stats as cs
ON hs.country = cs.country;

SELECT hs.year, hs.happiness_score, cs.continent
FROM happiness_scores AS hs
INNER JOIN country_stats as cs
ON hs.country = cs.country
ORDER BY hs.happiness_score DESC;

SELECT hs.year, hs.happiness_score, cs.country, cs.continent
FROM happiness_scores AS hs
INNER JOIN country_stats as cs
ON hs.country = cs.country
WHERE cs.country = 'United States'
ORDER BY hs.happiness_score DESC;

-- 2. Join types
-- Inner Join

SELECT hs.year, hs.country, hs.happiness_score, cs.continent, cs.continent
FROM happiness_scores AS hs
INNER JOIN country_stats as cs
ON hs.country = cs.country
WHERE Hs.country is null
ORDER BY hs.happiness_score DESC;

-- Left Join
SELECT hs.year, hs.country, hs.happiness_score, cs.continent, cs.continent
FROM happiness_scores AS hs
LEFT JOIN country_stats AS cs
	ON hs.country = cs.country
WHERE cs.country is null;

SELECT hs.year, hs.country, hs.happiness_score, cs.continent, cs.continent
FROM happiness_scores AS hs
RIGHT JOIN country_stats AS cs
	ON hs.country = cs.country
WHERE hs.country is null;

-- 3. Joining on multiple tables
SELECT distinct hs.country
FROM happiness_scores AS hs
LEFT JOIN country_stats AS cs
	ON hs.country = cs.country
WHERE cs.country is null;

SELECT distinct cs.country
FROM happiness_scores AS hs
RIGHT JOIN country_stats AS cs
	ON hs.country = cs.country
WHERE hs.country is null;

-- 4. Joining on MULTIPLE COLUMNS
SELECT * FROM happiness_scores;
SELECT * FROM country_stats;
SELECT * FROM inflation_rates;

SELECT * 
FROM happiness_scores AS h
INNER JOIN inflation_rates as i
on h.country = i.country_name and h.year = i.year; 

-- 5. Joining on MULTIPLE TABLES
SELECT * FROM happiness_scores;
SELECT * FROM country_stats;
SELECT * FROM inflation_rates;

SELECT 
	hs.year,
    hs.country,
    hs.happiness_score,
	cs.continent, 
    ir.inflation_rate
FROM happiness_scores as hs -- left most table
LEFT JOIN country_stats as cs
	ON hs.country = cs.country
LEFT JOIN inflation_rates as ir
	ON hs.year = ir.year and hs.country = ir.country_name;

SELECT 
	hs.year,
    hs.country,
    AVG(hs.happiness_score) AS average_happiness_score,
	cs.continent, 
    ir.inflation_rate
FROM happiness_scores as hs -- left most table
LEFT JOIN country_stats as cs
	ON hs.country = cs.country
LEFT JOIN inflation_rates as ir
	ON hs.year = ir.year and hs.country = ir.country_name
GROUP BY 
    hs.year, 
    hs.country,
    cs.continent, 
    ir.inflation_rate
ORDER BY hs.year, average_happiness_score DESC;

-- SELF JOIN
SELECT * FROM employees;

-- Employee with the same salary
SELECT *
FROM employees as e1
INNER JOIN employees as e2
	on e1.salary = e2.salary
WHERE e1.employee_name <> e2.employee_name 
	AND e1.employee_id > e2.employee_id;

-- Here is the final query
SELECT e1.employee_id, e1.employee_name, e1.salary,
	   e2.employee_id, e2.employee_name, e2.salary
FROM employees as e1
INNER JOIN employees as e2
	on e1.salary = e2.salary
WHERE e1.employee_id > e2.employee_id;

-- Employees that have a greater salary
SELECT e1.employee_id, e1.employee_name, e1.salary,
	   e2.employee_id, e2.employee_name, e2.salary
FROM employees as e1
INNER JOIN employees as e2
	on e1.salary > e2.salary
ORDER BY e1.employee_id;

-- Employees and their managers
SELECT * 
FROM employees;

-- Final query
SELECT e1.employee_id, e1.employee_name, e1.manager_id,
e2.employee_name as manager_name
FROM employees as e1
LEFT JOIN employees as e2
ON e1.manager_id = e2.employee_id;

