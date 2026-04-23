-- Section 2 Fundamentals
-- Udemy The Complete SQL bootcamp class
select * from customer;

SELECT first_name, last_name, email
FROM customer;

SELECT *
FROM film;

SELECT DISTINCT release_year
FROM film;

SELECT DISTINCT rental_rate FROM film;

SELECT DISTINCT rating FROM film;

SELECT COUNT(film_id) FROM film;

SELECT * FROM payment;

SELECT COUNT(*) FROM payment;

SELECT COUNT(amount) FROM payment;

SELECT COUNT(DISTINCT amount) FROM payment;

SELECT * FROM customer;

SELECT * 
FROM customer
WHERE first_name = 'Jared';

SELECT * FROM film;

SELECT 	* 
FROM 	film
WHERE 	rental_rate > 4 
	AND replacement_cost >= 19.99 
	AND rating = 'R';

SELECT 	COUNT(title) 
FROM 	film
WHERE 	rental_rate > 4 
	AND replacement_cost >= 19.99 
	AND rating = 'R';

SELECT 	COUNT(*)
FROM 	film
WHERE 	rating = 'PG-13' 
	OR  rating = 'R';

SELECT 	*
FROM 	film
WHERE 	rating <> 'R';

SELECT *
FROM customer
WHERE first_name = 'Nancy' AND last_name ='Thomas';

SELECT * FROM film;

SELECT title, description
FROM film
WHERE title ='Outlaw Hanky';

SELECT * FROM customer;

SELECT phone
FROM address
WHERE address ='259 Ipoh Drive';

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id, first_name;

SELECT * FROM payment
where amount <> 0.00
ORDER BY payment_date DESC
LIMIT 5;

SELECT * FROM customer;

SELECT * FROM payment;

SELECT * FROM payment
ORDER BY payment_date ASC
LIMIT 10;

SELECT * FROM film;

SELECT title, length 
FROM film
ORDER BY length ASC
LIMIT 5;

SELECT title
FROM film
WHERE length <= 50;

SELECT COUNT(title)
FROM film
WHERE length <= 50;

SELECT *
FROM payment
LIMIT 2;

SELECT COUNT(*)
FROM payment
WHERE amount NOT BETWEEN 8 AND 9;

SELECT *
FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

SELECT COUNT(*) FROM payment
WHERE amount IN (0.99, 1.98, 1.99);

SELECT COUNT(*) FROM payment
WHERE amount NOT IN (0.99, 1.98, 1.99);

SELECT * FROM customer
WHERE first_name IN ('John', 'Jake', 'Julie');

SELECT *
FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

SELECT *
FROM customer
WHERE first_name LIKE '%her%';

SELECT *
FROM customer
WHERE first_name LIKE '_her%';


SELECT *
FROM customer
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B';

SELECT COUNT(*)
FROM payment
WHERE amount > 5; --3618

SELECT *
FROM actor
WHERE first_name LIKE 'P%';

/*
"actor_id"	"first_name"	"last_name"	"last_update"
1	"Penelope"	"Guiness"	"2013-05-26 14:47:57.62"
46	"Parker"	"Goldberg"	"2013-05-26 14:47:57.62"
54	"Penelope"	"Pinkett"	"2013-05-26 14:47:57.62"
104	"Penelope"	"Cronyn"	"2013-05-26 14:47:57.62"
120	"Penelope"	"Monroe"	"2013-05-26 14:47:57.62"
*/

SELECT COUNT(DISTINCT district)
FROM address; -- 378

SELECT DISTINCT district
FROM address;

SELECT COUNT(title)
FROM film
WHERE rating ='R' AND replacement_cost BETWEEN 5 and 15; --52


SELECT COUNT(title)
FROM film
WHERE title LIKE '%Truman%'; --5
