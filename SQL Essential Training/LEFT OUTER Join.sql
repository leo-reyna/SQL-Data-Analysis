/*
Created by: RL
Date Created: Feb 20, 2023
Description: 
Joins and aliases
*/

SELECT 
	i.InvoiceId,
	i.CustomerId,
	c.FirstName,
	c.LastName,
	i.InvoiceDate AS 'Invoice Date',
	i.BillingAddress AS 'Invoice Billing Address',
	i.total AS 'Invoice Total'
FROM 
	invoice AS i
LEFT OUTER JOIN
	customer AS c
ON
	i.CustomerId = c.CustomerId
