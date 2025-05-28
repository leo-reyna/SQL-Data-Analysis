-- 1. Subqueries in the SELECT clause
-- Average Happiness Score
SELECT AVG(HAPPINESS_SCORE) AS AVG_HAPPINESS_SCORE
FROM happiness_scores; -- Average is 5.44

-- Happiness score deviation from the average
SELECT year, country, happiness_score,
(SELECT AVG(HAPPINESS_SCORE) FROM happiness_scores) as avg_hs,
happiness_score - (SELECT AVG(HAPPINESS_SCORE) FROM happiness_scores) as diff_from_avg   
FROM happiness_scores

-- Assignment Subqueries in the select clause
-- Produce a list of our products from the most to least expensive, along with how much each product differs from the average price of all products.
SELECT 
    product_id,
    product_name,
    unit_price,
    (SELECT AVG(unit_price) FROM products) AS avg_price,
    unit_price - (SELECT AVG(unit_price) FROM products) AS diff_price
FROM products
ORDER BY unit_price DESC;


-- 2. Subqueries in the FROM clause
-- Return each country's average happiness score, along with the country's avergae happiness scores.
SELECT hs.year, 
       hs.country, 
       hs.happiness_score,
       country_hs.avg_hs_by_country 
FROM happiness_scores AS hs
LEFT JOIN
        (SELECT country, AVG(happiness_score) AS avg_hs_by_country
        FROM happiness_scores
        GROUP BY country) AS country_hs
ON hs.country = country_hs.country

-- view one country's happiness scores
SELECT hs.year, 
       hs.country, 
       hs.happiness_score,
       country_hs.avg_hs_by_country 
FROM happiness_scores AS hs
LEFT JOIN
        (SELECT country, AVG(happiness_score) AS avg_hs_by_country
        FROM happiness_scores
        GROUP BY country) AS country_hs
ON hs.country = country_hs.country
WHERE hs.country = 'United States'  

-- Using Multiple Subqueries

-- this query stacks the historical and current happiness scores for each country
SELECT  hs.year, 
        hs.country, 
        hs.happiness_score,
        country_hs.avg_hs_by_country
FROM
        (SELECT year, country, happiness_score  
        FROM happiness_scores
        UNION ALL
        SELECT 2024, country, ladder_score 
        FROM happiness_scores_current) as hs
LEFT JOIN
        (SELECT country, AVG(happiness_score) AS avg_hs_by_country
        FROM happiness_scores
        GROUP BY country) AS country_hs
ON hs.country = country_hs.country;

-- Nested Subqueries
-- this query stacks the historical and current happiness scores for each country
SELECT *
FROM (
    SELECT  hs.year, 
            hs.country, 
            hs.happiness_score,
            country_hs.avg_hs_by_country
    FROM
            (SELECT year, country, happiness_score  
            FROM happiness_scores
            UNION ALL
            SELECT 2024, country, ladder_score 
            FROM happiness_scores_current) as hs
    LEFT JOIN
            (SELECT country, AVG(happiness_score) AS avg_hs_by_country
            FROM happiness_scores
            GROUP BY country) AS country_hs
    ON hs.country = country_hs.country
) AS hs_country_hs
WHERE happiness_score > avg_hs_by_country + 1.0;

-- 3. Multiple Subqueries
-- Return happiness scores for 2015 - 2024 
SELECT DISTINCT year FROM happiness_scores; -- data from 2015-2023
SELECT * FROM happiness_scores_current; -- data from 2024

SELECT year, country, happiness_score
FROM happiness_scores AS hs