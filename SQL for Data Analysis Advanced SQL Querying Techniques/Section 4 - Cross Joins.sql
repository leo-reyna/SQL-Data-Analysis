SELECT p1.product_name, p1.unit_price, 
       p2.product_name, p2.unit_price,
       p1.unit_price - p2.unit_price AS price_difference
FROM    products AS p1
CROSS   JOIN products AS p2
WHERE   ABS(p1.unit_price - p2.unit_price) < 0.25    
        and p1.product_name < p2.product_name
ORDER BY price_difference DESC;