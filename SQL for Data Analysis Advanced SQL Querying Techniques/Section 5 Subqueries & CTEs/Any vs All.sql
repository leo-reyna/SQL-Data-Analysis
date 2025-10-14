-- Active: 1745290413437@@127.0.0.1@3306@journey_to_space
USE maven_advanced_sql;

-- SCORES THAT ARE GREATER THAN ANY OF THE CURRENT OF ANY 2024 SCORES
SELECT *
FROM    happiness_scores
WHERE   happiness_score > 
        ANY(select ladder_score from happiness_scores_current);

-- SCORES THAT ARE GREATER THAN ALL 2024 SCORES
SELECT *
FROM    happiness_scores
WHERE   happiness_score > 
        ALL(select ladder_score from happiness_scores_current);
