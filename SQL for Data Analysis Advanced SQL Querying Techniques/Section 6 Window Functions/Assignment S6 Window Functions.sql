-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql

-- Windows Functions Basic
-- Assignment Section 6 - Number 1: 

-- view columns of interest

SELECT * FROM orders;

-- Columns of Interest
SELECT  customer_id, transaction_id, order_id, order_date
FROM    orders
ORDER BY customer_id, transaction_id;

-- For each customer, add a column for transaction number
SELECT  
        customer_id, 
        transaction_id, 
        order_id, 
        order_date,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY transaction_id) as transaction_number
FROM    orders
ORDER BY customer_id, transaction_id;

-- Assignment Section 6 - Number 2: 
-- Create a product rank field that returns a 1 for the most popular product in an order, 2 for second most, and so on. 
-- Show us ranks if they tie

SELECT * FROM orders;
-- For each order, rnak the products from most units to fewest units
-- if there is a tie, keep the tie and dont skip to the next number after

SELECT
        order_id,
        product_id,
        units,
        ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY units DESC) as prod_num,
        RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS prod_rank
FROM    orders
ORDER BY order_id, prod_num

-- Check the order Id that ends with 44262 from the results preview
SELECT
        order_id,
        product_id,
        units,
        DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS prod_rank
FROM    orders
WHERE order_id LIKE '%44262'
ORDER BY order_id, prod_rank 

-- Find the 2nd most popular product with each order
-- order_id / product_id / units

SELECT * FROM  orders;

-- view the ranking from last assignment

SELECT
        order_id,
        product_id,
        units,
        DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS prod_rank
FROM    orders       
ORDER BY order_id, prod_rank;

-- Add a column that contains the 2nd most popular product
SELECT
        order_id,
        product_id,
        units,
        NTH_VALUE(product_id, 2) OVER(PARTITION BY order_id ORDER BY units DESC) AS second_prod
FROM    orders       
ORDER BY order_id, second_prod;

-- Creating a CTE to get the 2nd most popular item
WITH    CTE1 AS 
(
        SELECT
                order_id,
                product_id,
                units,
                NTH_VALUE(product_id, 2) OVER(PARTITION BY order_id ORDER BY units DESC) AS second_prod
        FROM    orders   
        ORDER BY order_id, second_prod
)
SELECT *  
FROM    CTE1
WHERE   product_id = second_prod

-- USING DENSE RANK
SELECT
        order_id,
        product_id,
        units,
        DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS prod_rank
FROM    orders       
ORDER BY order_id, prod_rank;

WITH CTE2 AS (
        SELECT
        order_id,
        product_id,
        units,
        DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS prod_rank
FROM    orders       
ORDER BY order_id, prod_rank
)
SELECT  *
FROM     CTE2
WHERE   prod_rank = 2;

-- Assgignment: Value Relative to a ROW
-- How orders have changed overtime for each customer
-- produce a table that contains info about each
-- customer and their change in units form order to order


SELECT * FROM orders;
SELECT 
        customer_id,
        order_id,
        SUM(units) as total_units,
        LAG(units) OVER(PARTITION BY customer_id ORDER BY order_id) as prior_units
FROM orders
GROUP BY customer_id, order_id; 