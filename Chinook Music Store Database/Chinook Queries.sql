USE Chinook

/*
Create a query that create a list of customers who are not in the USA, 
include their customer ID, full name and country
*/

SELECT 
    CustomerId, 
    FirstName + ' ' + LastName as FullName, 
    Country
FROM dbo.Customer
WHERE Country <> 'USA'

/* Insight:46 Customers are from USA */

-- Employee with the most customers
SELECT 
    e.FirstName + ' ' + e.LastName as FullName,
    COUNT(c.CustomerId) as TotalCustomers
FROM dbo.Employee As e
INNER JOIN dbo.Customer as c 
ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId, e.FirstName, e.LastName
ORDER BY TotalCustomers;

/* Insight:
Steve J., Margaret P. and Jane P. with 18, 20 and 21 Customers respectively*/

-- Who are our top Customers according to Invoices?
SELECT TOP 5
    c.FirstName + ' ' + c.LastName as CustomerFullName,
    SUM(i.total) as TotalSum
FROM dbo.Invoice AS i 
INNER JOIN dbo.Customer as c 
ON c.CustomerId = i.CustomerId
group by c.customerid, c.FirstName, c.LastName
order by TotalSum desc;

/* 
Insight:
Helena Holy, Richard Cunningham, Luis Rojas, Ladislav Kovacs, 
and Hugh O’Reilly are the top five customers who have spent 
the highest amount of money according to the invoice table.
*/

/*
Select the email, first and last names of the customers, 
and the Genre and filter the Genre to Rock music.
*/
SELECT c.email, c.firstName, c.LastName, gr.Name
FROM dbo.customer as c
INNER JOIN dbo.Invoice as i
on c.customerID = i.CustomerId
INNER JOIN dbo.InvoiceLine as il 
ON i.InvoiceId = il.InvoiceLineId
INNER JOIN dbo.Track AS tr 
ON il.TrackId = tr.TrackId
INNER JOIN dbo.Genre as gr 
ON tr.GenreId = gr.GenreId
WHERE gr.Name = 'Rock'
GROUP BY c.Email,c.FirstName,c.LastName,gr.Name
ORDER BY 2,3

/* Insight:
We found out that all 59 customers 
in the database have listened to Rock Music.
*/

-- Create a query showing a unique list of billing countries from the Invoice table

SELECT DISTINCT BillingCountry
FROM dbo.Invoice

-- Who are the top 5 artists to produce most albums?

SELECT 
TOP 5 ART.Name AS ArtistName, 
COUNT(ALB.AlbumId) AS AlbumCount
FROM dbo.Album AS ALB
LEFT JOIN dbo.Artist AS ART 
    ON ALB.ArtistId = ART.ArtistId
GROUP BY ART.Name
ORDER BY AlbumCount DESC;
/* Insight:
Insight: 5 artist were found (Iron Maiden, Led Zeppelin, Deep Purple
Metallica and U2 with 21,14,11,10, 10 instances respectively)
*/
-- Number of tracks sold per genre

SELECT  
    gr.Name as [Genre Name], 
    sum(tr.TrackId) as [Num of Tracks Sold] 
FROM dbo.InvoiceLine as il 
LEFT JOIN dbo.Track as tr 
    ON il.TrackId = tr.TrackId
LEFT JOIN dbo.Genre as gr 
    ON gr.GenreId = tr.GenreId
GROUP by gr.Name
ORDER BY [Num of Tracks Sold] DESC;

-- Rock Sales by Year

SELECT 
    YEAR(inv.InvoiceDate) as YearDate,
    grt.Name,
    FORMAT(SUM(inv.Total), 'C','EN-US') as YearlyTotal
FROM dbo.invoice as inv 
LEFT JOIN InvoiceLine as inl
    ON inv.InvoiceId = inl.InvoiceId
LEFT JOIN dbo.Track as trk
    ON inl.TrackId = trk.TrackId
LEFT JOIN dbo.Genre as grt 
    ON trk.GenreId = grt.GenreId
WHERE grt.Name like 'Rock'
GROUP BY YEAR(InvoiceDate), grt.Name
ORDER BY YEAR(InvoiceDate) DESC;

-- What are the top 3 cities

WITH CitySales AS (
    SELECT
        c.city,
        SUM(i.Total) AS TotalSales,
        ROW_NUMBER() OVER (ORDER BY SUM(Total) DESC) AS RowNum
    FROM dbo.Invoice AS i 
    LEFT JOIN dbo.Customer AS c 
    ON i.CustomerId = c.CustomerId
    GROUP BY c.city
)
SELECT
    city,
    FORMAT(TotalSales, 'C', 'EN-US') AS TotalSales
FROM CitySales
WHERE RowNum <= 3;

-- Top 5 billing countries

WITH CountrySalesTop5 as (
SELECT inv.BillingCountry,
    SUM(inv.Total) AS TotalSales,
    ROW_NUMBER() OVER (ORDER BY SUM(Total) DESC) AS RowNum 
FROM dbo.Invoice as inv
LEFT JOIN dbo.InvoiceLine as inl 
    ON inv.InvoiceId = inl.InvoiceId 
GROUP BY inv.BillingCountry
)
SELECT 
    BillingCountry,
    FORMAT(TotalSales, 'c', 'en-us') AS TotalSales
    FROM CountrySalesTop5
    WHERE RowNum <= 5