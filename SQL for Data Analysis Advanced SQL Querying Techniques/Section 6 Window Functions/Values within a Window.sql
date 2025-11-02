
-- FIRST_VALUE, LAST_VALUE & NTH VALUE
-- Creating a new table
CREATE TABLE baby_names(
    gender VARCHAR(10),
    name VARCHAR(50),
    babies INT);
INSERT into baby_names(gender, name, babies)
VALUES
            ('Female', 'Charlotte', '80'), 
            ('Female', 'Emma', '82'), 
            ('Female', 'Olivia', '99'), 
            ('Male', 'James', '85'), 
            ('Male', 'Liam', '110'), 
            ('Male', 'Noah', '95');

-- View the table
SELECT * from baby_names
