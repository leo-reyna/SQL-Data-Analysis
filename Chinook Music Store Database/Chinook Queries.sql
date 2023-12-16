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