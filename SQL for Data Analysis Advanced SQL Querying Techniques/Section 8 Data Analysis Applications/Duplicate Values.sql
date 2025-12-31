-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql
USE maven_advanced_sql

-- 1. DUPLICATE VALUES

CREATE TABLE employees_details (
    region VARCHAR(50),
    employee_name VARCHAR(50),
    salary INTEGER
)

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

SELECT  employee_name, 
        count(*) as dup_count
FROM    employees_details
GROUP BY employee_name
HAVING count(*) > 1;