/* 
RL March 12 2023
Description: NON AGGREGATED Subqueries in the SELECT Clause/statement
How each individual city was performing global average sales
to show the average subtotals of invoices by city.
use wsda_music
*/

SELECT 
	InvoiceDate, 
	BillingAddress, 
	BillingCity
FROM 
	Invoice
WHERE 
InvoiceDate >
(SELECT InvoiceDate as [Invoice Dtae]
FROM Invoice
WHERE InvoiceID = 251)--Where "251" is an actual date given to you: 2012-01-09