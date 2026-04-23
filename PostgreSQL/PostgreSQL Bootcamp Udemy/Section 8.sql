--https://www.postgresql.org/docs/current/datatype.html

CREATE TABLE account(
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(250) UNIQUE NOT NULL,
    created_on TIMESTAMP NOT NULL,
    last_loging TIMESTAMP
)

CREATE TABLE job(
    job_id SERIAL PRIMARY KEY,
    job_name VARCHAR(200) UNIQUE NOT NULL
)

CREATE TABLE account_job(
    user_id INTEGER REFERENCES account(user_id),
    job_id INTEGER REFERENCES job(job_id),
    hire_date TIMESTAMP
)

select * from account;

INSERT INTO account (
    username,
    password,
    email,
    created_on,
    last_loging
)
VALUES
('Jose', 'Pass123!', 'joser.user01@example.com', CURRENT_TIMESTAMP, NULL),
('max_user01', 'Pass123!', 'max.user01@example.com', NOW() - INTERVAL '10 days', NOW() - INTERVAL '1 days'),
('maria_smith', 'Pass123!', 'maria.smith@example.com', NOW() - INTERVAL '9 days', NULL),
('john_doe88', 'Pass123!', 'john.doe88@example.com', NOW() - INTERVAL '8 days', NOW() - INTERVAL '2 hours'),
('sara_klein', 'Pass123!', 'sara.klein@example.com', NOW() - INTERVAL '7 days', NULL),
('david_ross', 'Pass123!', 'david.ross@example.com', NOW() - INTERVAL '6 days', NOW() - INTERVAL '5 days'),
('nina_jones', 'Pass123!', 'nina.jones@example.com', NOW() - INTERVAL '5 days', NULL),
('tommy_wells', 'Pass123!', 'tommy.wells@example.com', NOW() - INTERVAL '4 days', NOW() - INTERVAL '3 hours'),
('kevin_liu', 'Pass123!', 'kevin.liu@example.com', NOW() - INTERVAL '3 days', NULL),
('amy_walker', 'Pass123!', 'amy.walker@example.com', NOW() - INTERVAL '2 days', NOW() - INTERVAL '1 hour'),
('robert_gray', 'Pass123!', 'robert.gray@example.com', NOW() - INTERVAL '1 days', NULL);

INSERT INTO job(job_name)
VALUES
('Data Analyst'),
('Software Engineer'),
('Project Manager'),
('Customer Support Specialist'),
('Marketing Coordinator'),
('Human Resources Assistant'),
('Financial Analyst'),
('Operations Manager'),
('IT Support Technician'),
('Business Intelligence Developer');

SELECT * FROM job;
SELECT * FROM account_job;

INSERT INTO account_job (user_id, job_id, hire_date)
VALUES
(2, 1, '2024-01-15'),   -- max_user01 → Data Analyst
(3, 2, '2024-02-10'),   -- maria_smith → Software Engineer
(4, 3, '2024-03-05'),   -- john_doe88 → Project Manager
(5, 4, '2024-03-18'),   -- sara_klein → Customer Support Specialist
(6, 5, '2024-04-01'),   -- david_ross → Marketing Coordinator
(7, 6, '2024-04-12'),   -- nina_jones → HR Assistant
(8, 7, '2024-04-20'),   -- tommy_wells → Financial Analyst
(9, 8, '2024-05-02'),   -- kevin_liu → Operations Manager
(10, 9, '2024-05-10'),  -- amy_walker → IT Support Technician
(11, 10, '2024-05-15'); -- robert_gray → BI Developer

SELECT 
    a.username, 
    j.job_name, 
    aj.hire_date
FROM account_job as aj
JOIN account as a 
    ON a.user_id = aj.user_id 
JOIN job as j 
    ON aj.job_id = j.job_id;

SELECT * FROM account;

UPDATE account
SET last_loging = CURRENT_TIMESTAMP
WHERE user_id = 1;

SELECT * FROM job;
SELECT * FROM account_job;
select * from account;

UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id;

UPDATE account
SET last_loging = CURRENT_TIMESTAMP
RETURNING emaiil, last_loging;

INSERT INTO job(job_name)
VALUES('Laborer')

INSERT INTO account( 
    username,
    password,
    email,
    created_on,
    last_loging
)
VALUES
(
    'armando', 'Pass123!', 'armandor.user01@example.com', CURRENT_TIMESTAMP, NULL
)


INSERT INTO account_job (user_id, job_id, hire_date)
VALUES
(1, 11, '2024-01-25'),   -- jose → laborer
(12, 11, '2024-02-20'),   -- armando → laborer

UPDATE account
SET username = 'armando_smith'
WHERE account.user_id = 12;

UPDATE account
SET username = 'jose_carbone'
WHERE account.user_id = 1;

SELECT * FROM account;

CREATE TABLE informacion
(
    info_id serial PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    person VARCHAR(50) NOT NULL UNIQUE
    
)

SELECT * FROM informacion;

ALTER TABLE informacion
RENAME TO information;

SELECT * FROM information;

ALTER TABLE information
RENAME COLUMN person TO people