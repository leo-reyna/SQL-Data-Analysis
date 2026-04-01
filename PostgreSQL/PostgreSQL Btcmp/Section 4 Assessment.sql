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


-- Return the customers IDs of customers who have spent at least $110 in payment transactions with staff ID number 2
-- A: customers should be 187 and 148

SELECT  customer_id,
        SUM(amount)
FROM    payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 110;

-- How many films begin with the letter J?

SELECT * FROM film;

SELECT COUNT(*)
FROM film
WHERE title like 'J%';

-- What customer has the highest customer ID number whose name
-- starts with an 'E' and has an address ID lower than 500?

SELECT *
FROM customer;
SELECT
        customer_id,
        address_id,
        first_name,
        last_name
FROM customer
WHERE first_name LIKE 'E%' AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1