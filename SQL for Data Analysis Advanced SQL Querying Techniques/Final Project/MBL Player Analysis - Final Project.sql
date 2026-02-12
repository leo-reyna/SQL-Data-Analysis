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
-- 2. For each team, show the cumulative sum of spending over the years (Rolling Calculations)
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

/*
 NTILE(5) OVER(ORDER BY avg(total_spend) DESC) AS spend_perc
 This splits teams into 5 equal buckets:
- Tile 1 → top 20%
- Tile 2 → next 20%
- …
- Tile 5 → bottom 20%
*/

-- 2. For each team, show the cumulative sum of spending over the years

SELECT * FROM salaries;

WITH yearly as(
    SELECT  
        yearID, 
        teamID, 
        SUM(salary) as total_spend
    FROM salaries
    GROUP BY teamID, yearID
)
SELECT  
        yearID, 
        teamID, 
        total_spend,
        ROUND(SUM(total_spend) OVER(
                                PARTITION BY teamID 
                                ORDER BY yearID
                                ROWS UNBOUNDED PRECEDING) / 1000000, 1) AS cumulative_spend_mils
FROM yearly
ORDER BY teamID, yearID;

-- 3. Return the first year that each team's cumulative spending surpasses 1 billion
WITH yearly AS (
    SELECT  
        yearID, 
        teamID, 
        SUM(salary) AS total_spend
    FROM salaries
    GROUP BY teamID, yearID
), 
cumulative AS (
    SELECT  
        yearID, 
        teamID, 
        SUM(total_spend) OVER(
            PARTITION BY teamID 
            ORDER BY yearID
            ROWS UNBOUNDED PRECEDING) AS cumulative_spend
    FROM yearly
),
threshold AS (
    SELECT 
        teamID,
        yearID as first_year_over_1B,
        cumulative_spend,
        ROW_NUMBER() OVER (
            PARTITION BY teamID 
            ORDER BY yearID
        ) AS rn
    FROM cumulative
    WHERE cumulative_spend > 1000000000
AND teamID IS NOT NULL
)
SELECT 
    teamID,
    first_year_over_1B,
    ROUND(cumulative_spend / 1000000000, 2) cumulative_sum_billions
FROM threshold 
WHERE rn = 1
ORDER BY teamID;

/*
  ASSIGNMENT: Player Career Analysis
Using the Sean Lahman Baseball Database, complete the following steps
a) For each player, calculate their age at their first (debut) game, their last game, and 
their career length (all in years). Sort from longest career to shortest career.
b) What team did each player play on for their starting and ending years?
c) How many players started and ended on the same team and also played for over a decade?
*/


/*
For each player, calculate their age at their first (debut) game, their last game, and 
their career length (all in years). Sort from longest career to shortest career.
*/

--  View the players table and find the number of players in the table
SELECT * FROM players;
SELECT COUNT(*) FROM players;


-- I had to fix the format of the debut and finalGame columns to be able to do date calculations on them. 
-- I added two new columns to the players table, debut_date and final_date, and then updated those columns with the properly 
-- formatted dates. I also checked for any weird or malformed entries that couldn't be converted to dates.

ALTER TABLE players
ADD COLUMN debut_date DATE,
ADD COLUMN final_date DATE;

UPDATE players
SET debut_date =
        CASE
            WHEN debut REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
                THEN CAST(debut AS DATE)
            WHEN debut REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
                THEN STR_TO_DATE(debut, '%m/%d/%y')
            ELSE NULL
        END,
    final_date =
        CASE
            WHEN finalGame REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
                THEN CAST(finalGame AS DATE)
            WHEN finalGame REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
                THEN STR_TO_DATE(finalGame, '%m/%d/%y')
            ELSE NULL
        END;
-- any weird or malformed entries.
SELECT nameGiven, debut, debut_date, finalGame, final_date
FROM players
WHERE debut_date IS NULL OR final_date IS NULL;

-- deleting the original debut and finalGame columns since we have the properly formatted debut_date and final_date columns now.
ALTER TABLE players
DROP COLUMN debut,
DROP COLUMN finalGame;

-- rename the new date COLUMNs to be debut and finalGame so that the rest of the queries work without needing to change the column names.

ALTER TABLE players
CHANGE debut_date debut DATE,
CHANGE final_date finalGame DATE;
UPDATE players
SET debut = 2042-04-23

-- For each player, calculate their age at their first (debut) game, their last game, and
-- their career length (all in years). Sort from longest career to shortest career.


SELECT  nameGiven,
        playeriD,
        debut,
        finalGame,
        CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE) AS birth_date,
        TIMESTAMPDIFF(YEAR, CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), debut) as ageAtDebut,
        TIMESTAMPDIFF(YEAR, CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), finalGame) as ageAtFinal,
    FROM players
ORDER BY career_length_years DESC, ageAtDebut DESC;



-- Task 3: What team did each player play on for their starting and ending years?
SELECT playerId, nameGiven, debut, finalGame
FROM players;

SELECT playerId, yearID, teamID
FROM salaries;

SELECT 
        --p.playerId, 
        p.nameGiven, 
        p.debut, 
        p.finalGame,
        s.yearId as starting_year,
        s.teamId as starting_team,
        e.yearId as ending_year,
        e.teamId as ending_team
FROM players AS P
INNER JOIN salaries AS s
    ON p.playerId = s.playerId AND YEAR(p.debut) = s.yearId
INNER JOIN salaries AS e
    ON p.playerId = s.playerId AND YEAR(p.finalGame) = e.yearId

-- Task 4: How many players started and ended on the same team and also played for over a decade?

SELECT 
        -- p.playerId, 
        p.nameGiven, 
        p.debut, 
        p.finalGame,
        s.yearId as starting_year,
        s.teamId as starting_team,
        e.yearId as ending_year,
        e.teamId as ending_team
FROM players AS P
INNER JOIN salaries AS s
    ON p.playerId = s.playerId AND YEAR(p.debut) = s.yearId
INNER JOIN salaries AS e
    ON p.playerId = s.playerId AND YEAR(p.finalGame) = e.yearId
WHERE s.teamId = e.teamId and e.yearId - s.yearId > 10;

/*
ASSIGNMENT: Player Comparison Analysis
Using the Sean Lahman Baseball Database, complete the following steps
a) Which players have the same birthday?

b) Create a summary table that shows for each team, 
what percent of players bat right, left and both.

c) How have average height and weight at debut game changed over the years, 
and what's the decade-over-decade difference?
*/

-- a) Which players have the same birthday?

SELECT * FROM players;

WITH bn as(
    SELECT 
    nameGiven, 
    CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE) AS birthdate
FROM players
)
SELECT  
    birthdate, 
    GROUP_CONCAT(nameGiven SEPARATOR ', ') as player_names
FROM bn
WHERE YEAR(birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate
ORDER BY birthdate;

-- b) Create a summary table that shows for each team,
-- what percent of players bat right, left and both.    

SELECT * FROM players;

SELECT DISTINCT(bats) FROM players;

SELECT 
    s.teamID, 
    ROUND(SUM(CASE WHEN p.bats = 'R' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_right,
    ROUND(SUM(CASE WHEN p.bats = 'L' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_left,
    ROUND(SUM(CASE WHEN p.bats = 'B' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_both
FROM salaries AS s
JOIN players AS p
    ON s.playerId = p.playerId
GROUP BY s.teamID
