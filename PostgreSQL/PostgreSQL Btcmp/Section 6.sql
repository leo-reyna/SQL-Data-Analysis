-- db:dvdrental
-- Timestamps and Extract - Part 1

 SHOW ALL

SHOW TIMEZONE

SELECT NOW()

SELECT timeofday()

SELECT CURRENT_DATE

-- EXTRACTING INFORMATION FROM A TIME BASED

SELECT * FROM payment;
SELECT EXTRACT(YEAR FROM payment_date) as my_year
FROM payment;

SELECT EXTRACT(QUARTER FROM payment_date) as my_QT
FROM payment;

SELECT EXTRACT(MONTH FROM payment_date) as pay_month
FROM payment;

SELECT AGE(payment_date)
FROM payment;

-- functions formatting: https://www.postgresql.org/docs/18/functions-formatting.html

SELECT to_char(payment_date, 'Day dd, Mon YYYY')
from payment;

SELECT to_char(payment_date, 'mm dd, YYYY')
from payment;

-- Quick Question: during which month did payments occur? format your answer to return back the full month name

SELECT DISTINCT(to_char(payment_date, 'MONTH'))
from payment;

-- How many payments occurred on a Monday? 
SELECT COUNT(*)
FROM payment
WHERE EXTRACT(DOW FROM payment_date) = 1; 
-- 1 = monday
-- A: 2948 payments in Monday

-- Mathematical Functions and Operators
-- https://www.postgresql.org/docs/current/functions-math.html

SELECT * FROM film;

SELECT round(rental_rate/replacement_cost, 2) * 100 as percent_cost 
FROM film;

SELECT 0.1 * replacement_cost as deposit
from film;

-- String Functions and Operators
SELECT * FROM customer;

SELECT first_name || ' ' || last_name as fullname
FROM customer;

SELECT LENGTH(first_name) as lenght_of_name
FROM customer;

SELECT upper(first_name) || ' ' || upper(last_name) as fullname
FROM customer;

SELECT LOWER(LEFT(first_name,1)) || LOWER(last_name) || '@gmail.com' as custom_email
FROM customer

-- Subqueries,  EXIST function

SELECT * FROM film;

SELECT title, rental_rate
FROM film
WHERE rental_rate > 
(SELECT AVG(rental_rate)FROM film)

SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT i.film_id, f.title
FROM rental as r
INNER JOIN inventory as i
    ON i.inventory_id = r.inventory_id
INNER JOIN film as f
    ON i.film_id = f.film_id
WHERE return_date BETWEEN '2005-05-29' AND '2025-05-30'

-- also can be written

SELECT film_id, title
FROM film
WHERE film_id IN 
(SELECT i.film_id
FROM rental as r
INNER JOIN inventory as i
    ON i.inventory_id = r.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2025-05-30')
ORDER BY film_id;

-- EXISTS
SELECT first_name, last_name
FROM customer as c
WHERE EXISTS
(SELECT * FROM payment as p
WHERE p.customer_id = c.customer_id AND amount > 11)

SELECT first_name, last_name
FROM customer as c
WHERE NOT EXISTS
(SELECT * FROM payment as p
WHERE p.customer_id = c.customer_id AND amount > 11)

-- SELF JOIN

SELECT e1. name as employee, e2.name AS rep
FROM employees as e1
JOIN employees as e2
    ON e1.emp_id = e2.emp_did;

SELECT f1.title, f2.title, f1.length 
from film as f1
INNER JOIN film as f2
    ON f1.film_id <> f2.film_id
    AND f1.length = f2.length;

select * from film;
select * from language;