/* RL 031223 
SELECT Clause SUB QUERY
Description: 
Where the total is less than the average total amount
Average invoice amount by BillingCity
Use wsda_music.db
*/
SELECT
	strftime('%Y-%m-%d',InvoiceDate)
	BillingAddress,
	BillingCity,
	total
FROM
	Invoice
WHERE 
	total < (SELECT AVG(total) FROM Invoice) --inner QUERY
ORDER BY
	total DESC