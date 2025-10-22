/*
Created by: RL
Date Created: Feb 20, 2023
Description: 
Get all invoices that are greater than 1.98 from any cities
whose name starts with "p" OR starts with "d"
answer there are 56 records
PEMDAS usage
BEMDAS usage Brackets INSTEAD of Parenthesis. See below
Brackets, Exponents, Mult, Div, Addition, Subtraction
*/

SELECT
	InvoiceDate, 
	BillingAddress, 
	BillingCity, 
	total
FROM 
	Invoice
WHERE
	total > 1.98 AND (BillingCity LIKE 'P%' OR BillingCity LIKE 'D%')
ORDER BY
	InvoiceDate