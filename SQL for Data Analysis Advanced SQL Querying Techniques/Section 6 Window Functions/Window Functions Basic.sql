
SELECT *
FROM happiness_scores;

-- Return all row numbers
SELECT
        country,
        year,
        happiness_score,
        ROW_NUMBER() OVER () as row_num
FROM    happiness_scores
ORDER BY country, year;


SELECT 
    country,
    year,
    happiness_score,
    ROW_NUMBER() OVER () 
FROM happiness_scores

-- Return all row numbers within each windo
SELECT 
    country,
    year,
    happiness_score,
    ROW_NUMBER() OVER (PARTITION BY country) 
FROM happiness_scores

SELECT 
        country, 
        year, 
        happiness_score, 
        ROW_NUMBER() OVER(PARTITION BY country ORDER BY year) as row_num
FROM    happiness_scores;

SELECT 
            country, 
            year, 
            happiness_score, 
            ROW_NUMBER() OVER (PARTITION BY country ORDER BY happiness_score DESC) as row_num
FROM        happiness_scores
ORDER BY    country, row_num;

