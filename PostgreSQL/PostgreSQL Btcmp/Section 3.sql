SELECT MAX(replacement_cost) FROM film;

SELECT MIN(replacement_cost) FROM film;

SELECT ROUND(AVG(replacement_cost),2) FROM film;

SELECT ROUND(SUM(replacement_cost), 2) FROM film;

SELECT * FROM payment;

SELECT customer_id, SUM(amount) 
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount);

SELECT customer_id, COUNT(amount) 
FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount);

SELECT  customer_id,
        staff_id,
        SUM(amount)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY staff_id, customer_id;


SELECT DATE(payment_date), SUM(amount)
FROM payment
GROUP BY DATE(payment_date);

SELECT 
        DATE(payment_date), 
        SUM(amount)
FROM    payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount);

/*
We have two staff members with staff IDs one and two.
We want to give a bonus to the staff member that handled the most payments, most in terms of number
of payments processed, not total dollar amount.
So how many payments did each staff member handle and who gets the bonus?
*/

SELECT * FROM payment;
SELECT  staff_id,
        COUNT(*)
FROM    payment
GROUP BY staff_id;

/*
Corporate headquarters is conducting a study on the relationship between replacement cost 
and the movie's MPAA rating. That is to say its rating of G, PG, are, etc..

What is the average replacement cost per MPAA rating?
*/
SELECT * FROM film;

SELECT  rating,
        ROUND(AVG(replacement_cost),2) AS avg_cost_replacmnt
FROM film
GROUP BY rating


SELECT customer_id, SUM(amount) 
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT store_id, COUNT(*)
FROM customer
GROUP BY store_id
HAVING COUNT(*) > 300;

/*
We are launching a platinum service for our most loyal customers.
We will assign platinum status to customers that have had 40 or 
more transaction payments.

What customer IDs are eligible for platinum status?
*/
SELECT customer_id, count(*)
FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40;


/*
  What are the customer IDs of customers who have spent more than $100 
  in payment transactions with our staff? ID Member number 2 two again, 
  that's customer IDs of people who have spent more than $100 in payment
  transactions, but only with the payment transactions that occurred 
  with the staff ID number 2
*/

SELECT * FROM payment;

SELECT
        customer_id,
        SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id, staff_id
HAVING SUM(amount) > 100;