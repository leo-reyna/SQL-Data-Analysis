
USE maven_advanced_sql

-- 1. DUPLICATE VALUES
-- Crete the table
CREATE TABLE employees_details (
    region VARCHAR(50),
    employee_name VARCHAR(50),
    salary INTEGER
)
-- Add values
INSERT INTO employees_details(region, employee_name, salary) VALUES
    ('East', 'Ava', 85000),
    ('East', 'Ava', 85000),
    ('East', 'Bob', 72000),
    ('East', 'Cat', 59000),
    ('West', 'Cat', 63000),
    ('West', 'Dan', 85000),
    ('West', 'Eve', 72000),
    ('West', 'Eve', 75000);

SELECT * FROM employees_details;

-- 1. View duplicate employees
SELECT  employee_name, 
        count(*) as dup_count
FROM    employees_details
GROUP BY employee_name
HAVING count(*) > 1;

-- 1.1 View duplicate region and employee combos
SELECT  
        region,
        employee_name, 
        count(*) as dup_count
FROM    employees_details
GROUP BY employee_name, region
HAVING count(*) > 1;

-- 2 view fully duplicated rows
SELECT  
        region,
        salary,
        employee_name, 
        count(*) as dup_count
FROM    employees_details
GROUP BY employee_name, region, salary
HAVING count(*) > 1;

-- 3 Exclude duplicate rows
SELECT DISTINCT region, employee_name, salary
FROM employees_details;

-- 4 Exclude partially duplicate rows (unique employee name for each row)

SELECT region, employee_name, salary,
    ROW_NUMBER() OVER(PARTITION BY employee_name ORDER BY salary DESC) AS top_sal
    FROM employees_details;

-- use it as cte
WITH top_sal_cte as 
(
    SELECT region, employee_name, salary,
    ROW_NUMBER() OVER(PARTITION BY employee_name ORDER BY salary DESC) AS top_sal
    FROM employees_details
)
SELECT * 
FROM top_sal_cte 
WHERE top_sal = 1;


-- 4.1 Exclude partially duplicate rows (unique region + employee name for each row)
WITH top_sal_cte as 
(
    SELECT region, employee_name, salary,
    ROW_NUMBER() OVER(PARTITION BY region, employee_name ORDER BY salary DESC) AS top_sal
    FROM employees_details
)
SELECT * 
FROM top_sal_cte 
WHERE top_sal = 1;