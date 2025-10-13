use maven_advanced_sql;

SELECT * FROM happiness_scores

-- Average happiness score
SELECT AVG(happiness_score) AS avg_hs 
FROM happiness_scores;
-- AVERAGE IS 5.44

SELECT year, country, happiness_score, (SELECT AVG(happiness_score) 
                                        FROM happiness_scores) AS avg_hs
FROM happiness_scores;