/* 
RL March 12 2023
Description: IN Clause subquery
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
WHERE InvoiceDate IN
(SELECT InvoiceDate
FROM Invoice
WHERE InvoiceId IN (251, 252, 254))