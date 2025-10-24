-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql

-- Windows Functions Basic
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