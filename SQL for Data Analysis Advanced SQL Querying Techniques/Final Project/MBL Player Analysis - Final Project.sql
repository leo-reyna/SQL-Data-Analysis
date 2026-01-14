-- SQL for Data Analysis - Advannced SQL Querying Technique

-- PART I: SCHOOL ANALYSIS
-- 1. View the schools and school details tables
-- 2. In each decade, how many schools were there that produced players?
-- 3. What are the names of the top 5 schools that produced the most players?
-- 4. For each decade, what were the names of the top 3 schools that produced the most players?

-- Creating the database using the csv files provided:
-- players.csv, salaries.csv, school_details.csv, schools.csv


USE sean_lahman_baseball;

SELECT * FROM schools;

SELECT * FROM school_details;

-- 1. In each decade, how many schools were there that produced players?
SELECT 
    FLOOR(s.yearID / 10 ) * 10 as decade,
    COUNT(DISTINCT s.schoolID) as number_of_schools
FROM schools as s
INNER JOIN school_details as dt
    ON s.schoolID = dt.schoolID
GROUP BY decade
ORDER BY decade;


-- 2. What are the names of the top 5 schools that produced the most players?

SELECT 
    dt.name_full AS university,
    COUNT(DISTINCT s.playerID) AS player_count
FROM schools AS s
INNER JOIN school_details AS dt
    ON s.schoolID = dt.schoolID
GROUP BY dt.name_full
ORDER BY player_count DESC
LIMIT 5;
