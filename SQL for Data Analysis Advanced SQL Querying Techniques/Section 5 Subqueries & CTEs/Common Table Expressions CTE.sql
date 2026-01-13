-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql
-- SUBQUERIES VS CTEs
-- CTE reads better than subqueries in many cases
-- CTEs can be referenced multiple times in the main query

USE maven_advanced_sql;

/* SUBQUERY: Return the happiness scores along with
the average happness score for each country */

SELECT hs.year, 
       hs.country, 
       hs.happiness_score,
       country_hs.avg_hs_by_country 
FROM happiness_scores AS hs
LEFT JOIN
        (SELECT country, AVG(happiness_score) AS avg_hs_by_country
        FROM happiness_scores
        GROUP BY country) AS country_hs
ON hs.country = country_hs.country;

/* CTE: Return the happiness scores along with
the average happness score for each country */

WITH country_hs as (SELECT country, avg (happiness_score) AS avg_hs
                    FROM happiness_scores
                    GROUP BY country)
SELECT hs.YEAR, 
       hs.COUNTRY, 
       hs.HAPPINESS_SCORE,
       country_hs.avg_hs AS avg_hs_by_country  
FROM happiness_scores AS hs
LEFT JOIN country_hs
on hs.country = country_hs.country;

-- REFERENCE A CTE MULTIPLE TIMES
-- Reusability 
WITH hs AS ( SELECT *
            FROM happiness_scores
            WHERE YEAR = 2023 )
SELECT hs1.region, 
       hs1.country, 
       hs1.happiness_score,
       hs2.country, 
       hs2.happiness_score
FROM   hs AS hs1 -- can be referenced mult times
       INNER JOIN hs AS hs2
       on hs1.region = hs2.region
WHERE hs1.happiness_score > hs2.happiness_score; 


SELECT * FROM orders;
SELECT * FROM products;

SELECT * FROM orders;
SELECT * FROM products;

SELECT o.order_id, 
       p.product_id, 
       o.units, 
       p.unit_price,
       o.units * p.unit_price as total_amt_spent
       FROM orders as o
       LEFT JOIN products as p     
       ON o.product_id = p.product_id;

