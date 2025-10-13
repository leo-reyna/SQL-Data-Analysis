USE maven_advanced_sql;

SELECT * from tops
UNION
SELECT * FROM outerwear

-- union vs union all
-- view tables
SELECT * from tops;
SELECT * FROM outerwear;
SELECT * from sizes;

-- no duplicates
SELECT * from tops
UNION
SELECT * FROM outerwear

-- duplicates
SELECT * from tops
UNION ALL
SELECT * FROM outerwear

-- union with different columns names
SELECT * FROM happiness_scores;
SELECT * FROM happiness_scores_current;

SELECT * FROM happiness_scores;

SELECT * FROM happiness_scores;

SELECT DISTINCT year
FROM happiness_scores;

SELECT year, country, happiness_score FROM happiness_scores
UNION
SELECT 2024, country, ladder_score FROM happiness_scores_current

SELECT year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT 2024, country, ladder_score FROM happiness_scores_current