-- 5 NULL FUNCTIONS

-- Create the contacts table
CREATE TABLE contacts (
    name VARCHAR(50),
    email VARCHAR(100),
    alt_email VARCHAR(100));

INSERT INTO contacts(name, email, alt_email) VALUES
('Anna', 'anna@example.com', NULL),
('Bob', NULL, 'bob.alt@example.com'),
('Charlie', NULL, NULL),
('David', 'david@example.com','david.alt@example.com');

SELECT * FROM contacts;

-- Return null values
SELECT  * 
FROM    contacts
WHERE email IS NULL;

-- Return non-null values
SELECT  * 
FROM    contacts
WHERE email IS NOT NULL;

-- Return non-NULL values using a CASE statement
SELECT
        name,
        email,
        CASE WHEN email IS NOT NULL THEN email
        ELSE 'no email' END AS contact_email
FROM    contacts;

-- Return non-NULL values using IF NULL
SELECT
        name,
        email,
        IFNULL(email, 'No Email') AS contact_email
FROM contacts;

-- Return an alaternative field using IF NULL
SELECT
        name,
        email,
        alt_email,
        IFNULL(email, alt_email) AS contact_email
FROM contacts;

-- Return an alternative field after multiple checks
SELECT
        name,
        email,
        alt_email,
        IFNULL(email, 'No Email') AS contact_email_value,
        IFNULL(email, alt_email) AS contact_email_column,
        COALESCE(email, alt_email, 'no email') as contact_email_coalesce
FROM contacts;