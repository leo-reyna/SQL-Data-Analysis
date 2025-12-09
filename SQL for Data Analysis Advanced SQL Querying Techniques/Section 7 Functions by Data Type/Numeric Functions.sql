
-- Connect to database
USE maven_advanced_sql;

-- Math and rounding functions
SELECT * FROM country_stats;

SELECT  country, 
        population, 
        LOG(population, 10) as pop_log,
        ROUND(LOG(population), 2) as pop_log2
FROM country_stats;

-- Floor function for binning
WITH CTE1 AS (
SELECT  country, 
        population,
        FLOOR(population / 1000000) as population_in_million
FROM country_stats
)
SELECT 
        population_in_million, 
        count(country) as num_countries
FROM CTE1
GROUP BY population_in_million
ORDER BY population_in_million;

-- Max of a column vs masmax of a row: Least and greatest
-- Create a miles run table

CREATE TABLE miles_run(
    name VARCHAR(50),
    q1 INT,
    q2 INT,
    q3 INT,
    q4 INT
);

INSERT INTO miles_run(name, q1, q2, q3, q4)
VALUES
('Ali', 100, 200, 150, NULL),
('Bolt', 350, 400, 380, 300),
('Jordan', 200, 250, 300, 320)

SELECT * FROM miles_run

-- Return the greatest value of each COLUMN
SELECT MAX(q1), MAX(q2), MAX(q3), MAX(q4)
FROM miles_run

-- Return the greatest value of each ROW
SELECT GREATEST(q1, q2, q3, q4) as most_miles
FROM miles_run;

SELECT GREATEST(q1, q2, q3, q4) as most_miles
FROM miles_run;
SELECT GREATEST(q1, q2, q3, COALESCE(q4, 0)) as most_miles -- getting rid of the null and present the next greatest value
FROM miles_run;

