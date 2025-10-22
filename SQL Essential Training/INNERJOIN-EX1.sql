/* 
RL - MARCH 2023
Description: Inner Join Example
Use WSDA_Music.db
*/

SELECT *
FROM 
    Invoice
INNER JOIN
    Customer 
ON Invoice.CustomerId = Customer.CustomerId
ORDER BY Customer.CustomerID;


