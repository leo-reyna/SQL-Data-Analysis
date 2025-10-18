-- ASSIGNMENT:
-- Locating total amount spent that is over 200 dollars
-- only order_id and total_amt_spent columns should be in the final table
SELECT * FROM orders;
SELECT * FROM products;

SELECT o.order_id, 
       SUM(o.units * p.unit_price) as total_amt_spent
FROM orders as o
LEFT JOIN products as p     
       ON o.product_id = p.product_id
       GROUP BY order_id
       HAVING total_amt_spent > 200
       ORDER BY total_amt_spent DESC;



-- Return the number of orders over 200 dollars
With cte as(SELECT o.order_id, 
       SUM(o.units * p.unit_price) as total_amt_spent
       FROM orders as o
       LEFT JOIN products as p     
       ON o.product_id = p.product_id
       GROUP BY order_id
       HAVING total_amt_spent > 200
       ORDER BY total_amt_spent DESC
       )
SELECT COUNT(*)
FROM cte;