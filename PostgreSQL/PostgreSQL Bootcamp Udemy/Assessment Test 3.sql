
-- Created database "School" in PGAdmin
CREATE TABLE students
(
student_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
homeroom_number SMALLINT,
phone VARCHAR(20)  UNIQUE CHECK (phone ~ '^[0-9]+$') NOT NULL, -- digits only
email VARCHAR(255) UNIQUE NOT NULL,
graduation_year SMALLINT
)

ALTER TABLE students
ADD CONSTRAINT chk_graduation_year
CHECK (graduation_year BETWEEN 1900 AND 2100);

ALTER TABLE students
ADD CONSTRAINT chk_email_lowercase
CHECK (email = LOWER(email));

CREATE TABLE teachers
(
teacher_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
homeroom_number SMALLINT,
phone VARCHAR(20)  UNIQUE CHECK (phone ~ '^[0-9]+$') NOT NULL, -- digits only
email VARCHAR(255) UNIQUE NOT NULL
)

INSERT INTO students
(
    first_name,
    last_name,
    homeroom_number,
    phone,
    email,
    graduation_year
)
VALUES
(
    'Mark','Watney', 5, '7775551234', 'markw@dumbemail.com', 2035
)

SELECT * FROM students;

INSERT INTO teachers
(
    first_name,
    last_name,
    homeroom_number,
    phone,
    email
)
VALUES
(
    'Jonas','Salk', 5, '5555551111', 'jonasalk@dumbemail.com'
)

SELECT * FROM teachers;