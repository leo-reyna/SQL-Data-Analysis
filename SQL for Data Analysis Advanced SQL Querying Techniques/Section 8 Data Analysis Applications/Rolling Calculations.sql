-- ROLLING CALCULATIONS
CREATE TABLE pizza_orders (
    order_id INT PRIMARY KEY, 
    customer_name VARCHAR(50),
    order_date date,
    pizza_name VARCHAR(100),
    price DECIMAL(5, 2)
);

INSERT INTO pizza_orders (order_id, customer_name, order_date, pizza_name, price) VALUES
(1, 'Jack', '2024-12-01', 'Peperoni', 18.75),
(2, 'Jack', '2024-12-02', 'Peperoni', 18.75),
(3, 'Jack', '2024-12-04', 'Peperoni', 18.75),
(4, 'Jack', '2024-12-01', 'Peperoni', 18.75),
(5, 'Jack', '2024-12-01', 'Spicy Italian', 22.75),
(6, 'Jill', '2024-12-01', 'Five Cheese', 18.50),
(7, 'Jill', '2024-12-03', 'Margherita', 19.50),
(8, 'Jill', '2024-12-05', 'Garden Delight', 21.50),
(9, 'Jill', '2024-12-05', 'Greek', 21.50),
(10, 'Tom', '2024-12-01', 'Hawaiian', 19.50),
(11, 'Tom', '2024-12-04', 'Chicken Pesto', 20.75),
(12, 'Tom', '2024-12-02', 'Spicy Italian',22.75),
(13, 'Jack', '2024-12-01', 'California Chicken', 21.75),
(14, 'Jack', '2024-12-02', 'Margherita', 19.50),
(15, 'Jack', '2024-12-04', 'Greek', 21.50);

SELECT * FROM pizza_orders;

-- Calculate Customer Sub-Totals for each customer
SELECT
    customer_name,
    order_date, 
    SUM(price) AS total_sales
FROM pizza_orders
GROUP BY customer_name, order_date;

-- Include Subtotals #### SUB TOTALS ### 
SELECT
    customer_name,
    order_date, 
    SUM(price) AS total_sales
FROM pizza_orders
GROUP BY customer_name, order_date WITH ROLLUP;

-- Calculate the CUMULATIVE Sum of Sales over time:

-- View columns of interest
SELECT 
    order_date, 
    price 
FROM pizza_orders
ORDER BY order_date;

-- Calculate the total sales for EACH day
SELECT 
    order_date, 
    SUM(price) as total_sales
FROM pizza_orders
GROUP BY order_date
ORDER BY order_date;

-- Calculate the cumulative sales over time
WITH ts_cte as
(
    SELECT 
    order_date, 
    SUM(price) as total_sales
FROM pizza_orders
GROUP BY order_date
ORDER BY order_date
)
SELECT 
    ROW_NUMBER() OVER(ORDER BY order_date) as row_num,
    order_date,
    total_sales,
    SUM(total_sales) OVER(ORDER BY order_date)as cumulative_sum
FROM ts_cte;

--Calculate the 3 year moving average of happiness scores for each country
SELECT * FROM happiness_scores;

--View the happiness scores for each country, sorted by year
SELECT 
    country,
    year,
    happiness_score
FROM happiness_scores
ORDER BY country, year;

-- create a basic row number function window
SELECT 
    ROW_NUMBER() OVER(PARTITION BY country ORDER BY year) as row_num,
    country,
    year,
    happiness_score
FROM happiness_scores
ORDER BY country, year;

-- Update the function to a moving average
-- 
SELECT 
    ROW_NUMBER() OVER(PARTITION BY country ORDER BY year) as row_num,
    country,
    year,
    happiness_score,
    AVG(happiness_score) OVER(PARTITION BY country ORDER BY year) as moving_average
FROM happiness_scores
ORDER BY country, year;

-- 3 YEAR moving average
SELECT 
    ROW_NUMBER() OVER(PARTITION BY country ORDER BY year) as row_num,
    country,
    year,
    happiness_score,
    ROUND(AVG(happiness_score) OVER
       (PARTITION BY country ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 3) as moving_average
FROM happiness_scores
ORDER BY country, year;

--Assignment 8.2
SELECT *
FROM products

SELECT *
FROM orders;

--
-- 1st Calculate the total sales each month
SELECT 
    YEAR(o.order_date) AS yr,
    MONTH(o.order_date) AS mnth,
    SUM(p.unit_price * o.units) AS total_sales
FROM orders AS o
LEFT JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY YEAR(o.order_date), MONTH(o.order_date);

-- Add the cumulative sum and 6 month moving average
WITH cte1 as
(
SELECT 
    YEAR(o.order_date) AS yr,
    MONTH(o.order_date) AS mnth,
    SUM(p.unit_price * o.units) AS total_sales
FROM orders AS o
LEFT JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY YEAR(o.order_date), MONTH(o.order_date)
)
SELECT
    *,
    ROW_NUMBER() OVER (ORDER BY yr, mnth) as rn,
    SUM(total_sales) OVER (ORDER BY yr, mnth) AS cumulative_sum, -- CUMULATIVE SUM 
    AVG(total_Sales) OVER (ORDER BY yr, mnth ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS siX_month_moving_avg -- MOVING AVERAGE
FROM cte1
ORDER BY yr, mnth;