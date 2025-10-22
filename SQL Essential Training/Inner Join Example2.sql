/*
Created by: RL
Date Created: Feb 20, 2023
Description: 
Joins
*/

SELECT 
	*
FROM 
	Invoice
INNER JOIN
	Customer
ON
	Invoice.CustomerId = Customer.CustomerId
ORDER BY Customer.CustomerId