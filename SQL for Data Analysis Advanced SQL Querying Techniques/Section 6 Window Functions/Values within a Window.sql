-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql

-- FIRST_VALUE, LAST_VALUE & NTH VALUE
-- Creating a new table
CREATE TABLE baby_names(
    gender VARCHAR(10),
    name VARCHAR(50),
    babies INT);
INSERT into baby_names(gender, name, babies)
VALUES
            ('Female', 'Charlotte', '80'), 
            ('Female', 'Emma', '82'), 
            ('Female', 'Olivia', '99'), 
            ('Male', 'James', '85'), 
            ('Male', 'Liam', '110'), 
            ('Male', 'Noah', '95');

-- View the table
SELECT * from baby_names;

-- Return the first name in each window
SELECT 
        gender,
        name, 
        babies,
        FIRST_VALUE(name) OVER (PARTITION BY gender ORDER BY babies DESC) AS top_name
FROM baby_names
ORDER BY gender, babies DESC;

-- Return the top name for each gender
WITH top_nameCTE as(
    SELECT 
        gender,
        name, 
        babies,
        FIRST_VALUE(name) OVER (PARTITION BY gender ORDER BY babies DESC) AS top_name
    FROM baby_names)
SELECT *
FROM top_nameCTE
WHERE name = top_name;

-- Return the 2nd Name 
SELECT 
        gender,
        name, 
        babies,
        NTH_VALUE(name, 2) OVER (PARTITION BY gender ORDER BY babies DESC) AS second_name
    FROM baby_names;

-- RETURN THE 2ND NAME by gender
WITH top_nameCTE as(
    SELECT 
        gender,
        name, 
        babies,
        NTH_VALUE(name, 2) OVER (PARTITION BY gender ORDER BY babies DESC) AS second_name
    FROM baby_names)
SELECT *
FROM top_nameCTE
WHERE name = second_name;

-- Using ROW_NUMBER() TO GET THE 2ND MOST POPULAR NAME


WITH top_nameCTE as(
    SELECT 
        gender,
        name, 
        babies,
        ROW_NUMBER() OVER (PARTITION BY gender ORDER BY babies DESC) AS popularity
    FROM baby_names)
    SELECT * FROM top_nameCTE
    WHERE popularity = 2;

SELECT *
FROM baby_girl_names;

WITH 2PLACE AS (SELECT name, babies,
ROW_NUMBER() OVER(PARTITION BY babies ORDER BY name) as bbcount
FROM baby_girl_names)
SELECT *
FROM 2PLACE
WHERE bbcount = 1 

-- LEAD() AND LAG() 
-- Return the difference between yearly scores
WITH prior_yr_CTE as (
        SELECT 
                country, 
                year, 
                happiness_score,
                LAG(happiness_score) OVER(PARTITION BY country ORDER BY year) as prior_yr_happiness_score
                FROM happiness_scores
)
SELECT 
        country,
        year,
        happiness_score,
        prior_yr_happiness_score,
        happiness_score - prior_yr_happiness_score as hs_change
FROM    prior_yr_CTE;

