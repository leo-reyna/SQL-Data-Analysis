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
-- Lead and lag functions

SELECT * FROM orders;
SELECT 
        customer_id,
        order_id,
        product_id,
        transaction_id,
        units
FROM orders;

-- For each customer, return the total units within each order
SELECT 
        customer_id,
        order_id,
        SUM(units) as total_units
FROM orders
GROUP BY customer_id, order_id
ORDER BY customer_id;

--  Add on the transaction id to keep track of order sequence
SELECT 
        customer_id,
        order_id,
        min(transaction_id) as min_tid,
        SUM(units) as total_units
FROM orders
GROUP BY customer_id, order_id
ORDER BY customer_id, min_tid;

-- turn it into a CTE to view the columna of interest
WITH CTE1 AS (
                SELECT 
                        customer_id,
                        order_id,
                        min(transaction_id) as min_tid,
                        SUM(units) as total_units
                FROM orders
                GROUP BY customer_id, order_id
                ORDER BY customer_id, min_tid)
SELECT 
        customer_id,
        order_id,
        total_units
FROM CTE1;

-- create prior units column
WITH CTE1 AS (
                SELECT 
                        customer_id,
                        order_id,
                        min(transaction_id) as min_tid,
                        SUM(units) as total_units
                FROM orders
                GROUP BY customer_id, order_id
                ORDER BY customer_id, min_tid)
SELECT 
        customer_id,
        order_id,
        total_units,
        LAG(total_units) OVER (PARTITION BY customer_id ORDER BY min_tid) as prior_units
FROM CTE1;

-- For each customer, find the change in units per order over time

WITH CTE1 AS (
                SELECT 
                        customer_id,
                        order_id,
                        MIN(transaction_id) as min_tid,
                        SUM(units) as total_units
                FROM orders
                GROUP BY customer_id, order_id
                ORDER BY customer_id, min_tid
                ),
        
        CTE2 AS (
                SELECT 
                        customer_id,
                        order_id,
                        total_units,
                        LAG(total_units) OVER (PARTITION BY customer_id ORDER BY min_tid) as prior_units
                FROM CTE1
                )
SELECT 
        customer_id,
        order_id,
        total_units,
        prior_units,
        total_units - prior_units as diff_units         
FROM CTE2


-- Top 1% of Customers in terms of how much they've spent with us
-- This SQL query is trying to find the top 25% of customers by spending

WITH customer_spending AS (SELECT 
                                o.customer_id,
                                SUM(o.units * p.unit_price) as total_spent
                        FROM orders AS o
                        LEFT JOIN products AS p
                        ON o.product_id = p.product_id
                        GROUP BY o.customer_id ),

    customer_quartile AS (SELECT
                                customer_id,
                                total_spent,
                                NTILE(100) OVER(ORDER BY total_spent DESC) AS spent_pct
                        FROM customer_spending )
SELECT  *
FROM    customer_quartile
WHERE   spent_pct = 1