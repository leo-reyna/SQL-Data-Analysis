-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql
-- Multiple CTE's
-- Compare 2023 vs 2024 happiness scores side by side

WITH    hs23 as (SELECT * FROM happiness_scores WHERE YEAR = 2023),
        hs24 as (SELECT * FROM happiness_scores_current)
SELECT  hs23.country,
        hs23.happiness_score as hs_23,
        hs24.ladder_score as hs_24
FROM hs23
LEFT JOIN hs24
    ON hs23.country = hs24.country;


-- Return the countries where the score increased
SELECT * 
FROM (WITH  hs23 as (SELECT * FROM happiness_scores WHERE YEAR = 2023),
            hs24 as (SELECT * FROM happiness_scores_current)
            SELECT  hs23.country,
            hs23.happiness_score as hs_23,
            hs24.ladder_score as hs_24
            FROM hs23
            LEFT JOIN hs24
            ON hs23.country = hs24.country) AS hs_23_24
WHERE hs_24 > hs_23;

-- WITH CTEs only

WITH    hs23 as     (SELECT * FROM happiness_scores WHERE YEAR = 2023),
        hs24 as     (SELECT * FROM happiness_scores_current),
        hs23_24 as  (SELECT hs23.country,
                            hs23.happiness_score as hs_2023,
                            hs24.ladder_score as hs_2024
                     FROM hs23
                     LEFT JOIN hs24
                     ON hs23.country = hs24.country)
SELECT * 
FROM hs23_24
WHERE hs_2024 > hs_2023;