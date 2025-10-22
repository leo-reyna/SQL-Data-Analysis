/*
Created by: RL
Date Created: Feb 20, 2023
Description: 
How many customers purchased two songs at $0.99 each
*/

SELECT
	InvoiceDate, BillingAddress, Total
FROM 
	Invoice
WHERE
	Total = 1.98 
ORDER BY
	InvoiceDate
	
SELECT
	InvoiceDate, BillingAddress, Total
FROM 
	Invoice
WHERE
	Total = 1.98 
ORDER BY
	InvoiceDate
	

