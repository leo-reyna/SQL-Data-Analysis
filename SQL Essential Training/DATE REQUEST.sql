/*
Created by: RL
Date Created: Feb 20, 2023
Description: 
How many invoices were billed on 2010-05-22 00:00:00? THE DB USES THIS FORMAT
in its name?
*/

SELECT
	InvoiceDate, 
	BillingAddress, 
	BillingCity, 
	total
FROM 
	Invoice
WHERE
	--InvoiceDate = '2010-05-22 00:00:00' --dates are stored in single quotes
	DATE(InvoiceDate) = 2
ORDER BY
	InvoiceDate