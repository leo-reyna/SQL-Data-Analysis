/* 
Created by: RL
Created by: Feb 20, 2023
Description:  Structure of a basic query - joins
*/


SELECT DISTINCT Country
FROM Customer
ORDER BY Country ASC;

SELECT DISTINCT Genre.Name AS MusicType,  Track.Name AS Composer
FROM Genre
INNER JOIN Track
ON Genre.GenreId = Track.GenreId
ORDER BY Composer;


