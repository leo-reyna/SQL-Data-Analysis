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