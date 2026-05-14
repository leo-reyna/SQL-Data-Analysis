SELECT * FROM customer;

-- The frist 100 Customer Promo
-- CASE Statement

SELECT  customer_id,
CASE
    WHEN (customer_id <= 100) THEN 'Premium'
    WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus'
    ELSE 'Regular' 
END as Customer_Type
FROM customer;

SELECT  customer_id,
CASE customer_id 
    WHEN  2 THEN 'Winner'
    WHEN 8 THEN '2nd Place'
    ELSE 'Regular' 
END as raffle_results
FROM customer;

SELECT * FROM film;
--Produce a report with the following ratings - R, PG and PG13
SELECT
SUM(CASE rating
    WHEN 'R' THEN 1
    ELSE 0
END) AS rated_r_count,

SUM(CASE rating
    WHEN 'PG' THEN 1
    ELSE 0
END) AS rated_pg_count,

SUM(CASE rating
    WHEN 'PG-13' THEN 1
    ELSE 0
END) AS rated_pg_13_count
FROM film;

SELECT
SUM(CASE rental_rate
    WHEN 0.99 THEN 1 ELSE 0
END) AS num_bargains,

SUM(CASE rental_rate
    WHEN 2.99 THEN 1 ELSE 0
END) AS regular,

SUM(CASE rental_rate
    WHEN 4.99 THEN 1 ELSE 0
END) AS premium
FROM film;