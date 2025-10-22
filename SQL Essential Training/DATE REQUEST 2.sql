/*
Created by: RL
Date Created: Feb 20, 2023
Description: 
Get all invoices who's billing city starts with "p" OR starts with "d"
answer there are 56 records
*/

SELECT
	InvoiceDate, 
	BillingAddress, 
	BillingCity, 
	total
FROM 
	Invoice
WHERE
	BillingCity LIKE 'P%' OR BillingCity LIKE 'D%'
ORDER BY
	InvoiceDate