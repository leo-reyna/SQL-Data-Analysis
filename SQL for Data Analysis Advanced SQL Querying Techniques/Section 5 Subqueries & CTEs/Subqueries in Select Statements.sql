use maven_advanced_sql;

SELECT * FROM happiness_scores

-- Average happiness score
SELECT AVG(happiness_score) AS avg_hs 
FROM happiness_scores;
-- AVERAGE IS 5.44

SELECT year, country, happiness_score, (SELECT AVG(happiness_score) 
                                        FROM happiness_scores) AS avg_hs
FROM happiness_scores;

SELECT year, country, happiness_score, 
    (SELECT AVG(happiness_score) FROM happiness_scores) AS avg_hs,

         happiness_score - (SELECT AVG(happiness_score) AS avg_hs  FROM happiness_scores)
         AS hs_diff_from_avg        
FROM happiness_scores;

-- ASSIGNMENT - Give me a list of our products from most to least expensive,  
-- along with how much each product differs from the average price of all products.


SELECT product_id, product_name,unit_price,
(SELECT AVG(unit_price) AS avg_price FROM products) AS avg_price,
unit_price - (SELECT AVG(unit_price) AS avg_price FROM products) AS diff_price
FROM products
ORDER BY unit_price DESC;