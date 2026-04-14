-- DB: dvdrental 

SELECT COUNT(amount) as num_transactions
FROM payment;

SELECT customer_id, SUM(amount) as total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100; 

SELECT customer_id, amount
FROM payment
WHERE amount > 2;
SELECT * 
FROM customer

SELECT *
FROM payment;

SELECT  payment_id,
        p.customer_id,
        first_name
FROM payment AS p
INNER JOIN customer AS c
    ON p.customer_id = c.customer_id;

-- FULL OUTER JOINS
SELECT *
FROM payment

SELECT * 
FROM customer

-- Full Outer join
SELECT *
FROM customer as c
FULL OUTER JOIN payment as p
ON c.customer_id = p.customer_id;

-- Unique to table A and table B
-- No payment information associated with a payment

SELECT *
FROM customer as c
FULL OUTER JOIN payment as p
ON c.customer_id = p.customer_id
WHERE c.customer_id IS NULL OR p.payment_id is NULL;

select count(distinct customer_id) from payment; -- A: 599 customer ids
select count(distinct customer_id) from customer; -- A: 599 customer ids

-- Left Join (Left Outer Join)

SELECT * FROM film;
SELECT * FROM inventory;

SELECT film.film_id, title, inventory_id, store_id
FROM film 
LEFT JOIN inventory ON
inventory.film_id = film.film_id;

-- Finding out if it's in inventory (No inventory ID, not posted to sell)
SELECT film.film_id, title, inventory_id, store_id
FROM film 
LEFT JOIN inventory ON
inventory.film_id = film.film_id
WHERE inventory.film_id is NULL;

-- UNION

SELECT * FROM customer
UNION
SELECT * FROM payment;

-- JOIN Challenge Tasks
-- What are the emails of the customers that live in California
SELECT * FROM customer;
SELECT * FROM address;

SELECT a.district, c.email
FROM address as a
INNER JOIN customer as c
    ON a.address_id = c.address_id
WHERE a.district ='California';

-- Get a list of all the movies "Nick Wahlberg" has been in

SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT * FROM actor
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';
 -- actor_id 2

SELECT f.title, a.first_name, a.last_name
FROM film as f
INNER JOIN film_actor as fa
    ON f.film_id = fa.film_id
INNER JOIN actor as a
    ON fa.actor_id = a.actor_id
WHERE a.actor_id = 2;
-- OR WHERE a.first_name = 'Nick' AND a.last_name = 'Wahlberg';


