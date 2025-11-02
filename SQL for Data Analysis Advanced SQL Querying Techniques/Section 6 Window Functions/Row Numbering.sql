-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql
-- ROW NUMBERING
-- ROW_NUMBER() vs DENSE() vs DENSE_RANK()

CREATE TABLE baby_girl_names(
    name VARCHAR(50),
    babies INT);

DROP TABLE  baby_girl_names;

INSERT INTO baby_girl_names (name, babies) VALUES
('Olivia', 99),
('Emma', 80),
('Charlotte', 80),
('Amelia', 75),
('Sophia', 72),
('Isabella', 70),
('Ava', 70),
('Mia', 64);

-- View the table
SELECT * FROM baby_girl_names;

-- Compare ROW_NUMBER() vs RANK() vs RANK_DENSE()
SELECT  name,
        babies,
        ROW_NUMBER() OVER (ORDER BY babies DESC) AS babie_rownum,
        RANK() OVER (ORDER BY babies DESC) AS babies_rank,
        DENSE_RANK() OVER (ORDER BY babies DESC) AS babies_dense_rank
FROM    baby_girl_names;
