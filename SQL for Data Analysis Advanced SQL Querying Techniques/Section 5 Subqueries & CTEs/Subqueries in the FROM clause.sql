-- Return each country's average happiness score, along with the country's average happiness scores.
SELECT      country, 
            AVG(gdp_per_capita) AS avg_gdp_by_country
FROM        happiness_scores
GROUP BY    country;

-- Average by country
SELECT      country, AVG(happiness_score) AS avg_hs_by_country
FROM        happiness_scores
GROUP BY    country;


SELECT      hs.year, 
            hs.country, 
            hs.happiness_score,
            country_hs.avg_hs_by_country
FROM        happiness_scores As hs 
LEFT JOIN
            (SELECT country, avg (happiness_score) AS avg_hs_by_country
            FROM happiness_scores
            GROUP BY country) AS country_hs
ON hs.country = country_hs.country;

-- Just the United States
SELECT      hs.year, 
            hs.country, 
            hs.happiness_score,
            country_hs.avg_hs_by_country
FROM        happiness_scores As hs 
LEFT JOIN
            (SELECT country, avg (happiness_score) AS avg_hs_by_country
            FROM happiness_scores
            GROUP BY country) AS country_hs
ON hs.country = country_hs.country
WHERE hs.country = 'United States';