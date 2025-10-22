/*
Created by: RL
Date Created: Feb 20, 2023
Description: 
How many customers purchased two songs at $0.99 each AND 5.00
*/

SELECT
	InvoiceDate, BillingAddress, Total
FROM 
	Invoice
WHERE
	Total BETWEEN 1.98 AND 5.00
ORDER BY
	InvoiceDate

