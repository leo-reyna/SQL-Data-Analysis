use maven_advanced_sql;

CREATE TABLE sample_table(
    id INT,
    str_value VARCHAR(50)
);

INSERT INTO sample_table (id, str_value) VALUES
    (1, '100.2'),
    (2, '200.4'),
    (4, '300.6');

-- Select rows from a Table or View 'TableOrViewName' in schema 'SchemaName'
SELECT * FROM sample_table

SELECT id, str_value * 2
FROM sample_table;

-- TURN THE STRING TO A DECIMAL (MOST FORMAL APPROACH)
SELECT id, CAST(str_value AS DECIMAL(5,2)) * 2
FROM sample_table;

-- TURN AN INTEGER INTO A FLOAT
SELECT country, population / 5.0 
FROM country_stats;