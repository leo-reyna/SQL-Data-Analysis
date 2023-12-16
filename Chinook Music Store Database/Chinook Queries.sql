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

/* 
Create a query showing a unique list of billing countries 
from the Invoice table
*/

SELECT DISTINCT BillingCountry
FROM dbo.Invoice

/*
Who are the top 5 artists to produce most albums?
*/
SELECT 
TOP 5 ART.Name AS ArtistName, 
COUNT(ALB.AlbumId) AS AlbumCount
FROM dbo.Album AS ALB
LEFT JOIN dbo.Artist AS ART 
    ON ALB.ArtistId = ART.ArtistId
GROUP BY ART.Name
ORDER BY AlbumCount DESC;

/*
Number of tracks sold per genre
*/


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

/* Rock Sales by Year */
