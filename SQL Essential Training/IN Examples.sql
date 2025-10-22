/*
Created by: RL
Date Created: Feb 20, 2023
Description: 
How many invoices do we have 
that are exactly $1.98 or $3.96
We should have 168 invoices
*/

SELECT
	InvoiceDate, BillingAddress, Total
FROM 
	Invoice
WHERE
	Total IN(1.98, 3.96) -- that are exactly $1.98 or $3.96
ORDER BY
	InvoiceDate
