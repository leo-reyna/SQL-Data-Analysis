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