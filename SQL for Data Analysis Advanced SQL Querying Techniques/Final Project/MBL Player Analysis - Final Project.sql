-- Active: 1745290413437@@127.0.0.1@3306@sean_lahman_baseball
-- SQL for Data Analysis - Advannced SQL Querying Technique

-- PART I: SCHOOL ANALYSIS
-- 1. View the schools and school details tables
-- 2. In each decade, how many schools were there that produced players?
-- 3. What are the names of the top 5 schools that produced the most players?
-- 4. For each decade, what were the names of the top 3 schools that produced the most players?

-- Creating the database using the csv files provided:
-- players.csv, salaries.csv, school_details.csv, schools.csv


USE sean_lahman_baseball;

-- 1. View the schools and school details tables
SELECT * FROM schools;
SELECT * FROM school_details;
SELECT * from players;

-- 2. In each decade, how many schools were there that produced players? [numeric functions]

-- Solution from class:
SELECT 
    ROUND(yearID, -1) as decade,  -- rounds the year to the nearest 10
    COUNT(DISTINCT schoolID) AS num_schools
FROM schools
GROUP BY decade
ORDER BY decade;

-- My solution:
SELECT 
    CONCAT(FLOOR(yearID / 10) * 10, 's') AS decade, 
    COUNT(DISTINCT schoolID) AS num_schools
FROM schools
GROUP BY decade
ORDER BY decade;

-- 3. What are the names of the top 5 schools that produced the most players? [joints]

SELECT 
    sd.name_full as university,
    COUNT(DISTINCT s.playerID) as num_players
FROM schools AS s
LEFT JOIN school_details as sd
    ON s.schoolID = sd.schoolID
GROUP BY s.schoolID, sd.name_full
ORDER BY num_players DESC
LIMIT 5;


-- 4. For each decade, what were the names of the top 3 schools that produced the most players?

SELECT 
        FLOOR(yearID / 10) * 10 AS decade, 
        sd.name_full,
        COUNT(DISTINCT s.playerID) AS player_count
    FROM schools AS s
    LEFT JOIN school_details AS sd
        ON s.schoolID = sd.schoolID
    GROUP BY decade, sd.schoolID, sd.name_full

WITH ds AS (
    SELECT 
        FLOOR(yearID / 10) * 10 AS decade, 
        sd.name_full,
        COUNT(DISTINCT s.playerID) AS player_count
    FROM schools AS s
    LEFT JOIN school_details AS sd
        ON s.schoolID = sd.schoolID
    GROUP BY decade, sd.schoolID, sd.name_full
),
rn AS (
    SELECT 
        decade, 
        name_full,
        player_count,
        ROW_NUMBER() OVER (
            PARTITION BY decade 
            ORDER BY player_count DESC
        ) AS row_num
    FROM ds
)
SELECT  
    decade,
    name_full,
    player_count
FROM rn
WHERE row_num <= 3
ORDER BY decade DESC, row_num;

-- PART 2: Salary Analysis (window functions, rolling calculations, min/max filtering)
-- Using the Sean Lahman Baseball Database - Complete the following steps:
-- 1. Return the 20% of team in terms of average annual spending
-- 2. For each team, show the cumulative sum of spending over the years
-- 3. Return the first year that each team's cumulative spending surpasses 1 billion


SELECT * FROM salaries;

-- 1. Return the 20% of team in terms of average annual spending
WITH total_spend_cte AS(
            SELECT  
                teamID, 
                yearID, 
                SUM(salary) as total_spend
            FROM salaries
            GROUP BY teamID, yearID
            ORDER BY teamID, yearID
),
spent_perc_cte as (
            SELECT
                teamID, 
                AVG(total_spend) as avg_spend,
                NTILE(5) OVER(ORDER BY avg(total_spend) DESC) AS spend_perc
            FROM total_spend_cte
            GROUP BY teamID
)
SELECT teamID, round(avg_spend / 1000000, 1) as avg_spend_millions
FROM spent_perc_cte
WHERE spend_perc = 1;