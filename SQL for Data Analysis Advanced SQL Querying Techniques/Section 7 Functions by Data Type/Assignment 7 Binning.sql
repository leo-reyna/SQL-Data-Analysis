
SELECT * FROM orders

-- assignment 7: numeric functions
-- calculate the total spent for each customer

SELECT
    o.customer_id,
    o.product_id,
    o.units,
    p.product_id,
    p.unit_price,
    o.units * p.unit_price as total
FROM orders as o
LEFT JOIN products as p
    On o.product_id = p.product_id


SELECT
    o.customer_id,
    SUM ( o.units * p.unit_price ) as total_spent
FROM orders as o
LEFT JOIN products as p
    On o.product_id = p.product_id
GROUP BY o.customer_id;

-- put the spent into bins of $0 - $10, $10 -$20 etc
SELECT
    o.customer_id,
    SUM ( o.units * p.unit_price ) as total_spent,
    FLOOR(SUM (o.units * p.unit_price) / 10 ) * 10 as total_spent_bin
FROM orders as o
LEFT JOIN products as p
    On o.product_id = p.product_id
GROUP BY o.customer_id;

-- Number of customer in each spend bin
-- final query
WITH cte_bin as (
                SELECT
                    o.customer_id,
                    SUM ( o.units * p.unit_price ) as total_spent,
                    FLOOR(SUM (o.units * p.unit_price) / 10 ) * 10 as total_spent_bin
                FROM orders as o
                LEFT JOIN products as p
                    On o.product_id = p.product_id
                GROUP BY o.customer_id
)
SELECT 
            total_spent_bin,
            count(customer_id) as num_customers
FROM        cte_bin
GROUP BY    total_spent_bin
ORDER BY    total_spent_bin;