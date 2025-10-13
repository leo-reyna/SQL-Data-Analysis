
-- Return happiness scores for 2015 - 2023
SELECT DISTINCT year FROM happiness_scores; -- only has data through 2023
-- This Table has a ladder_score field which is the same as the happiness score field in the 2015-2023 table
-- Only has 2024 data   
SELECT * FROM happiness_scores_current; 


/* Return years where the happiness score is a whole point
greater than the country's average happiness score */

SELECT * FROM
(
SELECT      hs.year,
            hs.country,
            hs.happiness_score,
            country_hs.avg_hs_by_country

FROM       (SELECT year, country, happiness_score from happiness_scores
            UNION ALL
            SELECT 2024, country, ladder_score from happiness_scores_current) as hs 
LEFT JOIN
            (SELECT country, avg (happiness_score) AS avg_hs_by_country
            FROM happiness_scores
            GROUP BY country) AS country_hs
            ON hs.country = country_hs.country
) AS hs_country_hs

WHERE happiness_score > avg_hs_by_country + 1;

/*
« Assignment 2: Subqueries in the FROM clause »
« Reviewing products produced by each factory »
Need a List of factories along with the names of the products  they produce
and the number of products they produce. 
It should look like this: 
factory name, product_Name, num_products
===========================================
Factory 1,      Product A,      3
Factory 1,      Product B,      3
*/


SELECT factory, COUNT(product_id) AS numberofproducts 
FROM products
group by factory;

SELECT factory, product_name
FROM products


SELECT  fp.factory,
        fp.product_name,
        -- fn.factory,
        fn.num_products
FROM
    (SELECT factory, product_name
    FROM products) AS fp -- final product list

LEFT JOIN

    (SELECT factory, COUNT(product_id) AS num_products
    FROM products 
    GROUP BY factory) AS fn -- final numbers of products

ON fp.factory = fn.factory  
ORDER BY fp.factory, fp.product_name