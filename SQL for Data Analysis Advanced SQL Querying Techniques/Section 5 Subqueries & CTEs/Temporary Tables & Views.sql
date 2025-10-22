-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql
-- Temporary Table
CREATE TEMPORARY TABLE temp_table1 AS 
  SELECT YEAR, country, happiness_score
  FROM happiness_scores
UNION ALL
  SELECT 2024, country, ladder_score
  FROM happiness_scores_current
;
SELECT * FROM temp_table1;

-- Views
CREATE VIEW First_View AS
SELECT YEAR, country, happiness_score
FROM happiness_scores
UNION ALL
SELECT 2024, country, ladder_score
FROM happiness_scores_current;

SELECT * FROM first_view