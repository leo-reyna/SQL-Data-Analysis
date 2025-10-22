/* 
RL March 12 2023
Description: Aggregated Subqueries
How each individual city was performing global average sales
to show the average subtotals of invoices by city.
use wsda_music
*/

SELECT 
	BillingCity,
	AVG(total), -- average as billing city
	(SELECT ROUND(AVG(total),2) FROM Invoice) AS [Global Avg]-- global average
	
FROM
	Invoice
GROUP BY
	BillingCity
ORDER BY
	BillingCity
