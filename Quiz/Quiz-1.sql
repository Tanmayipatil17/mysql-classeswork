/*
Database - University

-- 1. create database university
-- 2. do proper analysis to organize data properly
-- 3. there must be 5 tables within minimum 5 attributes, insert 5 records. 
-- 4. do properdocumentation. 
-- 5. analyze table data & write situation based condition queries-
      1. create,insert,select,truncate,drop,
	  2.select queries {20}
      3.alter queries {20}
      4.update queries {20}
      5.delete queries {20}
*/

-- --------------------------------------------------- Analysis of Database ------------------------------------------------
/*
Database Name --> University

Tables -->

1. students (id,name,age,phone,year)
2. courses (id,name,credits,department,semester,instructor)
3. professors (id,name,department,experience,qualification,email)
4. department (id,name,head,facultycount,building,establishedyr)
5. admissions (id,studentname,course,status,feepaid)
*/
   
   -- ---------------------------------------- Database queries ---------------------------------------------------------
   
-- create a university database
create database University;

-- to work on database, you need to use it first
use University;

-- TABLE-1
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    phone VARCHAR(50),
    Year INT
);

insert into Students
values
(1, 'Alice Smith', 20, '12344', 2024),
(2, 'Bob Johnson', 22, '98765', 2023),
(3, 'Carol Davis', 19, '45627', 2025),
(4, 'David Lee', 21, '09876', 2022),
(5, 'Eva Brown', 20, '99876', 2021),
(6, 'Frank Harris', 23, '22345',2025),
(7, 'Grace Clark', 22, '16789', 2024),
(8, 'Hank Lewis', 21, '98876', 2025),
(9, 'Ivy Walker', 20, '88997', 2022),
(10, 'Jake Hall', 24, '44566', 2024);

-- to display table data
select * from Students;

-- to remove complete records from table
truncate table Students;

-- to remove complete records & attributes from table
drop table Students;


-- 20 select queries
-- 1. Select all records
SELECT * FROM Students;

-- 2. Select only names and phone numbers
SELECT Name, phone FROM Students;

-- 3. Select students older than 21
SELECT * FROM Students WHERE Age > 21;

-- 4. Select students from year 2025
SELECT * FROM Students WHERE Year = 2025;

-- 5. Select students whose name starts with 'A'
SELECT * FROM Students WHERE Name LIKE 'A%';

-- 6. Count total number of students
SELECT COUNT(*) AS TotalStudents FROM Students;

-- 7. Find average age of students
SELECT AVG(Age) AS AverageAge FROM Students;

-- 8. Get the youngest student(s)
SELECT * FROM Students WHERE Age = (SELECT MIN(Age) FROM Students);

-- 9. Get the oldest student(s)
SELECT * FROM Students WHERE Age = (SELECT MAX(Age) FROM Students);

-- 10. Select students sorted by name
SELECT * FROM Students ORDER BY Name;

-- 11. Select students sorted by year descending
SELECT * FROM Students ORDER BY Year DESC;

-- 12. Get students with phone number starting with '9'
SELECT * FROM Students WHERE phone LIKE '9%';

-- 13. Select distinct years
SELECT DISTINCT Year FROM Students;

-- 14. Select students aged between 20 and 22
SELECT * FROM Students WHERE Age BETWEEN 20 AND 22;

-- 15. Group by Year and count students
SELECT Year, COUNT(*) AS CountByYear FROM Students GROUP BY Year;

-- 16. Get student names in uppercase
SELECT UPPER(Name) AS UppercaseName FROM Students;

-- 17. Concatenate name and phone
SELECT CONCAT(Name, ' - ', phone) AS ContactInfo FROM Students;

-- 18. Select students with even StudentID
SELECT * FROM Students WHERE StudentID % 2 = 0;

-- 19. Get students not from year 2025
SELECT * FROM Students WHERE Year <> 2025;

-- 20. Get top 5 students by Age
SELECT * FROM Students ORDER BY Age DESC LIMIT 5;


-- 20 alter queries
-- 1. Add Email column
ALTER TABLE Students ADD Email VARCHAR(100);

-- 2. Add Gender column
ALTER TABLE Students ADD Gender VARCHAR(10);

-- 3. Rename column phone to PhoneNumber
ALTER TABLE Students RENAME COLUMN phone TO PhoneNumber;

-- 4. Modify Age to SMALLINT
ALTER TABLE Students MODIFY Age SMALLINT;

-- 5. Add column isActive with default true
ALTER TABLE Students ADD isActive BOOLEAN DEFAULT TRUE;

-- 6. Drop the Gender column
ALTER TABLE Students DROP COLUMN Gender;

-- 7. Rename table
ALTER TABLE Students RENAME TO UniversityStudents;

-- 8. Change column Year to GraduationYear
ALTER TABLE UniversityStudents RENAME COLUMN Year TO GraduationYear;

-- 9. Add a constraint on Age >= 18
ALTER TABLE UniversityStudents ADD CONSTRAINT chk_Age CHECK (Age >= 18);

-- 10. Add index on Name
CREATE INDEX idx_name ON UniversityStudents(Name);

-- 11. Drop index
DROP INDEX idx_name ON UniversityStudents;

-- 12. Add a unique constraint on Email
ALTER TABLE UniversityStudents ADD CONSTRAINT uq_email UNIQUE (Email);

-- 13. Drop unique constraint
ALTER TABLE UniversityStudents DROP INDEX uq_email;

-- 14. Set default value for isActive to FALSE
ALTER TABLE UniversityStudents ALTER isActive SET DEFAULT FALSE;

-- 15. Remove default from isActive
ALTER TABLE UniversityStudents ALTER isActive DROP DEFAULT;

-- 16. Change PhoneNumber length
ALTER TABLE UniversityStudents MODIFY PhoneNumber VARCHAR(20);

-- 17. Add created_at timestamp
ALTER TABLE UniversityStudents ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- 18. Add updated_at timestamp
ALTER TABLE UniversityStudents ADD updated_at TIMESTAMP;

-- 19. Rename column Name to FullName
ALTER TABLE UniversityStudents RENAME COLUMN Name TO FullName;

-- 20. Change table name back
ALTER TABLE UniversityStudents RENAME TO Students;


-- 20 update  queries
-- 1. Update phone number of student ID 1
UPDATE Students SET PhoneNumber = '11111' WHERE StudentID = 1;

-- 2. Set Year to 2026 for all students aged 23
UPDATE Students SET Year = 2026 WHERE Age = 23;

-- 3. Change name of student ID 2
UPDATE Students SET Name = 'Robert Johnson' WHERE StudentID = 2;

-- 4. Increase age of all students by 1
UPDATE Students SET Age = Age + 1;

-- 5. Set isActive to false for Year 2021
UPDATE Students SET isActive = FALSE WHERE Year = 2021;

-- 6. Set email for a student
UPDATE Students SET Email = 'alice@example.com' WHERE StudentID = 1;

-- 7. Nullify phone number for student ID 5
UPDATE Students SET PhoneNumber = NULL WHERE StudentID = 5;

-- 8. Set all years to 2025
UPDATE Students SET Year = 2025;

-- 9. Set GraduationYear = 2026 where Age > 22
UPDATE Students SET Year = 2026 WHERE Age > 22;

-- 10. Correct a typo in name
UPDATE Students SET Name = 'Carol Davies' WHERE Name = 'Carol Davis';

-- 11. Set default email for all null emails
UPDATE Students SET Email = 'not_provided@example.com' WHERE Email IS NULL;

-- 12. Truncate names longer than 10 characters
UPDATE Students SET Name = LEFT(Name, 10);

-- 13. Set Age = 25 where Year = 2022
UPDATE Students SET Age = 25 WHERE Year = 2022;

-- 14. Set isActive = true for all students
UPDATE Students SET isActive = TRUE;

-- 15. Add domain to phone numbers
UPDATE Students SET PhoneNumber = CONCAT(PhoneNumber, '@phone.com');

-- 16. Change Year to 2023 for students named 'Jake Hall'
UPDATE Students SET Year = 2023 WHERE Name = 'Jake Hall';

-- 17. Set updated_at to current timestamp
UPDATE Students SET updated_at = CURRENT_TIMESTAMP;

-- 18. Remove digits from Name (hypothetical case)
UPDATE Students SET Name = REGEXP_REPLACE(Name, '[0-9]', '');

-- 19. Set Age to NULL for ID 10
UPDATE Students SET Age = NULL WHERE StudentID = 10;

-- 20. Recalculate Year = 2000 + Age
UPDATE Students SET Year = 2000 + Age;

-- 20 delete queries
-- 1. Delete student with ID 10
DELETE FROM Students WHERE StudentID = 10;

-- 2. Delete students older than 23
DELETE FROM Students WHERE Age > 23;

-- 3. Delete all students from year 2021
DELETE FROM Students WHERE Year = 2021;

-- 4. Delete students with name 'Frank Harris'
DELETE FROM Students WHERE Name = 'Frank Harris';

-- 5. Delete students where phone starts with '9'
DELETE FROM Students WHERE PhoneNumber LIKE '9%';

-- 6. Delete students with NULL phone number
DELETE FROM Students WHERE PhoneNumber IS NULL;

-- 7. Delete all students (use with caution)
DELETE FROM Students;

-- 8. Delete students with even StudentID
DELETE FROM Students WHERE StudentID % 2 = 0;

-- 9. Delete where email is not set
DELETE FROM Students WHERE Email IS NULL;

-- 10. Delete students not in Year 2025
DELETE FROM Students WHERE Year <> 2025;

-- 11. Delete students with age less than 20
DELETE FROM Students WHERE Age < 20;

-- 12. Delete students with 'Lee' in their name
DELETE FROM Students WHERE Name LIKE '%Lee%';

-- 13. Delete students with duplicate names (advanced, may require JOIN/CTE)
DELETE FROM Students SELECT Name FROM Students GROUP BY Name HAVING COUNT(*) > 1;

-- 14. Delete students with invalid phone length
DELETE FROM Students WHERE LENGTH(PhoneNumber) < 5;

-- 15. Delete students whose name is NULL
DELETE FROM Students WHERE Name IS NULL;

-- 16. Delete students whose age is NULL
DELETE FROM Students WHERE Age IS NULL;

-- 17. Delete based on substring match in phone
DELETE FROM Students WHERE PhoneNumber LIKE '%76%';

-- 18. Delete students from specific list of IDs
DELETE FROM Students WHERE StudentID IN (2, 4, 6);

-- 19. Delete students created more than a year ago (if created_at exists)
DELETE FROM Students WHERE created_at < NOW() - INTERVAL 1 YEAR;

-- 20. Delete all students with isActive = false
DELETE FROM Students WHERE isActive = FALSE;


-- TABLE-2
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    department VARCHAR(50),
    semester VARCHAR(10),
    instructor VARCHAR(50)
);

INSERT INTO Courses VALUES
(101, 'Data Structures', 4, 'CS', 'Fall', 'Dr. Mehta'),
(102, 'Thermodynamics', 3, 'Mechanical', 'Spring', 'Dr. Iyer'),
(103, 'Linear Algebra', 4, 'Mathematics', 'Fall', 'Dr. Sen'),
(104, 'Quantum Physics', 3, 'Physics', 'Spring', 'Dr. Raina'),
(105, 'Digital Electronics', 4, 'Electronics', 'Fall', 'Dr. Rao'),
(106, 'Algorithms', 4, 'CS', 'Spring', 'Dr. Kapoor'),
(107, 'Fluid Mechanics', 3, 'Mechanical', 'Fall', 'Dr. Bhat'),
(108, 'Calculus', 4, 'Mathematics', 'Spring', 'Dr. Dasgupta'),
(109, 'Classical Mechanics', 3, 'Physics', 'Fall', 'Dr. Sinha'),
(110, 'VLSI Design', 4, 'Electronics', 'Spring', 'Dr. Nair');

-- to display table data
select * from Courses;

-- to remove complete records from table
truncate table Courses;

-- to remove complete records & attributes from table
drop table Courses;

-- 20 select queries
 -- 1. Select all courses
SELECT * FROM Courses;

-- 2. Select courses with 4 credits
SELECT * FROM Courses WHERE credits = 4;

-- 3. Select courses in Fall semester
SELECT * FROM Courses WHERE semester = 'Fall';

-- 4. Select CS department courses
SELECT * FROM Courses WHERE department = 'CS';

-- 5. Select course taught by Dr. Sen
SELECT * FROM Courses WHERE instructor = 'Dr. Sen';

-- 6. Select course names only
SELECT course_name FROM Courses;

-- 7. Select distinct departments
SELECT DISTINCT department FROM Courses;

-- 8. Select courses ordered by credits descending
SELECT * FROM Courses ORDER BY credits DESC;

-- 9. Select courses with names starting with 'D'
SELECT * FROM Courses WHERE course_name LIKE 'D%';

-- 10. Count of total courses
SELECT COUNT(*) FROM Courses;

-- 11. Average credits of courses
SELECT AVG(credits) FROM Courses;

-- 12. Maximum credits among all courses
SELECT MAX(credits) FROM Courses;

-- 13. Minimum credits among all courses
SELECT MIN(credits) FROM Courses;

-- 14. Courses offered in Spring semester
SELECT * FROM Courses WHERE semester = 'Spring';

-- 15. Instructors with more than one course
SELECT instructor, COUNT(*) FROM Courses GROUP BY instructor HAVING COUNT(*) > 1;

-- 16. Select courses from Electronics department
SELECT * FROM Courses WHERE department = 'Electronics';

-- 17. Select course by ID 105
SELECT * FROM Courses WHERE course_id = 105;

-- 18. Total courses per department
SELECT department, COUNT(*) FROM Courses GROUP BY department;

-- 19. Courses not in CS department
SELECT * FROM Courses WHERE department <> 'CS';

-- 20. List of instructors and their courses
SELECT instructor, course_name FROM Courses ORDER BY instructor;

-- 20 alter queries
-- 1. Add column for course duration
ALTER TABLE Courses ADD duration_weeks INT;

-- 2. Add column for course language
ALTER TABLE Courses ADD language VARCHAR(30);

-- 3. Modify credits to FLOAT
ALTER TABLE Courses MODIFY credits FLOAT;

-- 4. Rename instructor to professor
ALTER TABLE Courses CHANGE instructor professor VARCHAR(50);

-- 5. Drop the semester column
ALTER TABLE Courses DROP COLUMN semester;

-- 6. Add NOT NULL constraint to department
ALTER TABLE Courses MODIFY department VARCHAR(50) NOT NULL;

-- 7. Change course_name to 150 chars
ALTER TABLE Courses MODIFY course_name VARCHAR(150);

-- 8. Rename table to CourseList
ALTER TABLE Courses RENAME TO CourseList;

-- 9. Add unique constraint on course_name
ALTER TABLE CourseList ADD UNIQUE(course_name);

-- 10. Add default value to duration_weeks
ALTER TABLE CourseList ALTER duration_weeks SET DEFAULT 12;

-- 11. Rename column professor to lecturer
ALTER TABLE CourseList CHANGE professor lecturer VARCHAR(50);

-- 12. Drop column language
ALTER TABLE CourseList DROP COLUMN language;

-- 13. Add new column course_level
ALTER TABLE CourseList ADD course_level VARCHAR(20);

-- 14. Modify duration_weeks to SMALLINT
ALTER TABLE CourseList MODIFY duration_weeks SMALLINT;

-- 15. Set default department to 'General'
ALTER TABLE CourseList ALTER department SET DEFAULT 'General';

-- 16. Add CHECK constraint on credits
ALTER TABLE CourseList ADD CHECK (credits > 0);

-- 17. Drop course_level column
ALTER TABLE CourseList DROP COLUMN course_level;

-- 18. Rename table back to Courses
ALTER TABLE CourseList RENAME TO Courses;

-- 19. Rename column lecturer to instructor
ALTER TABLE Courses CHANGE lecturer instructor VARCHAR(50);

-- 20. Add column mode (online/offline)
ALTER TABLE Courses ADD mode VARCHAR(10);

-- 20 update queries
-- 1. Update instructor for Algorithms
UPDATE Courses SET instructor = 'Dr. Menon' WHERE course_id = 106;

-- 2. Set credits to 5 for Data Structures
UPDATE Courses SET credits = 5 WHERE course_id = 101;

-- 3. Update department of Calculus
UPDATE Courses SET department = 'Applied Math' WHERE course_name = 'Calculus';

-- 4. Change semester of Classical Mechanics to Spring
UPDATE Courses SET semester = 'Spring' WHERE course_name = 'Classical Mechanics';

-- 5. Change all Physics courses to have 4 credits
UPDATE Courses SET credits = 4 WHERE department = 'Physics';

-- 6. Change instructor of Thermodynamics
UPDATE Courses SET instructor = 'Dr. Gupta' WHERE course_id = 102;

-- 7. Change department of Fluid Mechanics
UPDATE Courses SET department = 'Civil' WHERE course_name = 'Fluid Mechanics';

-- 8. Update VLSI Design credits to 5
UPDATE Courses SET credits = 5 WHERE course_name = 'VLSI Design';

-- 9. Set semester to Fall for Algorithms
UPDATE Courses SET semester = 'Fall' WHERE course_name = 'Algorithms';

-- 10. Update instructor of Calculus
UPDATE Courses SET instructor = 'Dr. Patel' WHERE course_name = 'Calculus';

-- 11. Rename Digital Electronics to Microprocessors
UPDATE Courses SET course_name = 'Microprocessors' WHERE course_name = 'Digital Electronics';

-- 12. Change department of Microprocessors to Electrical
UPDATE Courses SET department = 'Electrical' WHERE course_name = 'Microprocessors';

-- 13. Set semester for all CS courses to Summer
UPDATE Courses SET semester = 'Summer' WHERE department = 'CS';

-- 14. Update instructor of Data Structures
UPDATE Courses SET instructor = 'Dr. Sharma' WHERE course_name = 'Data Structures';

-- 15. Change semester of Linear Algebra to Summer
UPDATE Courses SET semester = 'Summer' WHERE course_name = 'Linear Algebra';

-- 16. Update name of Classical Mechanics
UPDATE Courses SET course_name = 'Advanced Mechanics' WHERE course_name = 'Classical Mechanics';

-- 17. Change instructor of Quantum Physics
UPDATE Courses SET instructor = 'Dr. Neha' WHERE course_name = 'Quantum Physics';

-- 18. Change department of Algorithms
UPDATE Courses SET department = 'IT' WHERE course_name = 'Algorithms';

-- 19. Set all Math courses credits to 6
UPDATE Courses SET credits = 6 WHERE department = 'Mathematics';

-- 20. Reset instructor of all Electronics courses
UPDATE Courses SET instructor = 'TBD' WHERE department = 'Electronics';

-- 20 delete queries
-- 1. Delete course with ID 101
DELETE FROM Courses WHERE course_id = 101;

-- 2. Delete course named Thermodynamics
DELETE FROM Courses WHERE course_name = 'Thermodynamics';

-- 3. Delete all Mechanical department courses
DELETE FROM Courses WHERE department = 'Mechanical';

-- 4. Delete course with 3 credits
DELETE FROM Courses WHERE credits = 3;

-- 5. Delete course taught by Dr. Rao
DELETE FROM Courses WHERE instructor = 'Dr. Rao';

-- 6. Delete courses in Spring semester
DELETE FROM Courses WHERE semester = 'Spring';

-- 7. Delete course Algorithms
DELETE FROM Courses WHERE course_name = 'Algorithms';

-- 8. Delete Calculus course
DELETE FROM Courses WHERE course_name = 'Calculus';

-- 9. Delete course with ID 110
DELETE FROM Courses WHERE course_id = 110;

-- 10. Delete all Electronics department courses
DELETE FROM Courses WHERE department = 'Electronics';

-- 11. Delete all Fall semester courses
DELETE FROM Courses WHERE semester = 'Fall';

-- 12. Delete courses taught by Dr. Sinha
DELETE FROM Courses WHERE instructor = 'Dr. Sinha';

-- 13. Delete all CS courses
DELETE FROM Courses WHERE department = 'CS';

-- 14. Delete Linear Algebra course
DELETE FROM Courses WHERE course_name = 'Linear Algebra';

-- 15. Delete courses with more than 4 credits
DELETE FROM Courses WHERE credits > 4;

-- 16. Delete course with instructor Dr. Mehta
DELETE FROM Courses WHERE instructor = 'Dr. Mehta';

-- 17. Delete Advanced Mechanics
DELETE FROM Courses WHERE course_name = 'Advanced Mechanics';

-- 18. Delete Microprocessors course
DELETE FROM Courses WHERE course_name = 'Microprocessors';

-- 19. Delete courses with less than 4 credits
DELETE FROM Courses WHERE credits < 4;

-- 20. Delete all remaining records
DELETE FROM Courses;

-- TABLE-3
CREATE TABLE Professors1 (
    professor_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    experience INT,
    qualification VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO Professors1 VALUES
(1, 'Dr. Mehta', 'CS', 15, 'PhD', 'mehta@univ.edu'),
(2, 'Dr. Iyer', 'Mechanical', 12, 'PhD', 'iyer@univ.edu'),
(3, 'Dr. Sen', 'Mathematics', 20, 'PhD', 'sen@univ.edu'),
(4, 'Dr. Raina', 'Physics', 10, 'PhD', 'raina@univ.edu'),
(5, 'Dr. Rao', 'Electronics', 18, 'PhD', 'rao@univ.edu'),
(6, 'Dr. Kapoor', 'CS', 8, 'MTech', 'kapoor@univ.edu'),
(7, 'Dr. Bhat', 'Mechanical', 14, 'PhD', 'bhat@univ.edu'),
(8, 'Dr. Dasgupta', 'Mathematics', 9, 'PhD', 'dasgupta@univ.edu'),
(9, 'Dr. Sinha', 'Physics', 11, 'PhD', 'sinha@univ.edu'),
(10, 'Dr. Nair', 'Electronics', 16, 'PhD', 'nair@univ.edu');

-- to display table data
select * from Professors;

-- to remove complete records from table
truncate table Professors;

-- to remove complete records & attributes from table
drop table Professors;

-- 20 SELECT QUERIES
-- 1. Select all professors
SELECT * FROM Professors1;

-- 2. Select professors from CS department
SELECT * FROM Professors1 WHERE department = 'CS';

-- 3. Select professors with more than 15 years of experience
SELECT * FROM Professors1 WHERE experience > 15;

-- 4. Select professors with qualification 'PhD'
SELECT * FROM Professors1 WHERE qualification = 'PhD';

-- 5. Select professor names and emails
SELECT name, email FROM Professors1;

-- 6. Select professors with experience between 10 and 20
SELECT * FROM Professors1 WHERE experience BETWEEN 10 AND 20;

-- 7. Select professors ordered by experience DESC
SELECT * FROM Professors1 ORDER BY experience DESC;

-- 8. Select distinct departments
SELECT DISTINCT department FROM Professors1;

-- 9. Count of professors in each department
SELECT department, COUNT(*) FROM Professors1 GROUP BY department;

-- 10. Select professors whose names start with 'Dr. D'
SELECT * FROM Professors1 WHERE name LIKE 'Dr. D%';

-- 11. Check if any professor has MTech
SELECT * FROM Professors1 WHERE qualification = 'MTech';

-- 12. Select professor with highest experience
SELECT * FROM Professors1 ORDER BY experience DESC LIMIT 1;

-- 13. Select emails of Physics department
SELECT email FROM Professors1 WHERE department = 'Physics';

-- 14. Find total experience in CS department
SELECT SUM(experience) FROM Professors1 WHERE department = 'CS';

-- 15. List professors with exactly 12 years of experience
SELECT * FROM Professors1 WHERE experience = 12;

-- 16. Select professors ordered by name ASC
SELECT * FROM Professors1 ORDER BY name ASC;

-- 17. Select professors with experience less than 10
SELECT * FROM Professors1 WHERE experience < 10;

-- 18. List qualifications available
SELECT DISTINCT qualification FROM Professors1;

-- 19. Count of professors with each qualification
SELECT qualification, COUNT(*) FROM Professors1 GROUP BY qualification;

-- 20. Professors not from CS department
SELECT * FROM Professors1 WHERE department != 'CS';


-- 20 ALTER QUERIES
-- 1. Add a column for contact number
ALTER TABLE Professors1 ADD contact_number VARCHAR(20);

-- 2. Modify name length
ALTER TABLE Professors1 MODIFY name VARCHAR(100);

-- 3. Rename table
ALTER TABLE Professors1 RENAME TO Faculty;

-- 4. Rename table back
ALTER TABLE Faculty RENAME TO Professors1;

-- 5. Change qualification to NOT NULL
ALTER TABLE Professors1 MODIFY qualification VARCHAR(50) NOT NULL;

-- 6. Add unique constraint to email
ALTER TABLE Professors1 ADD CONSTRAINT unique_email UNIQUE(email);

-- 7. Drop the contact number column
ALTER TABLE Professors1 DROP COLUMN contact_number;

-- 8. Add date_of_joining column
ALTER TABLE Professors1 ADD date_of_joining DATE;

-- 9. Modify email length
ALTER TABLE Professors1 MODIFY email VARCHAR(150);

-- 10. Add gender column
ALTER TABLE Professors1 ADD gender VARCHAR(10);

-- 11. Set default value for experience
ALTER TABLE Professors1 ALTER experience SET DEFAULT 0;

-- 12. Change department to NOT NULL
ALTER TABLE Professors1 MODIFY department VARCHAR(50) NOT NULL;

-- 13. Add index on department
ALTER TABLE Professors1 ADD INDEX (department);

-- 14. Add index on experience
ALTER TABLE Professors1 ADD INDEX (experience);

-- 15. Drop index on department
ALTER TABLE Professors1 DROP INDEX department;

-- 16. Add column is_active
ALTER TABLE Professors1 ADD is_active BOOLEAN DEFAULT TRUE;

-- 17. Change email to NOT NULL
ALTER TABLE Professors1 MODIFY email VARCHAR(150) NOT NULL;

-- 18. Drop column gender
ALTER TABLE Professors1 DROP COLUMN gender;

-- 19. Drop column date_of_joining
ALTER TABLE Professors1 DROP COLUMN date_of_joining;

-- 20. Drop constraint on email
ALTER TABLE Professors1 DROP INDEX unique_email;


-- 20 UPDATE QUERIES
-- 1. Update experience of Dr. Mehta to 16
UPDATE Professors1 SET experience = 16 WHERE name = 'Dr. Mehta';

-- 2. Change department of Dr. Kapoor to IT
UPDATE Professors1 SET department = 'IT' WHERE name = 'Dr. Kapoor';

-- 3. Update email of Dr. Iyer
UPDATE Professors1 SET email = 'iyer_new@univ.edu' WHERE professor_id = 2;

-- 4. Change qualification of Dr. Dasgupta to MPhil
UPDATE Professors1 SET qualification = 'MPhil' WHERE name = 'Dr. Dasgupta';

-- 5. Set all CS professors to have experience 10
UPDATE Professors1 SET experience = 10 WHERE department = 'CS';

-- 6. Change name of Dr. Sen to Dr. S. Sen
UPDATE Professors1 SET name = 'Dr. S. Sen' WHERE name = 'Dr. Sen';

-- 7. Update all professors in Electronics to have 20 years experience
UPDATE Professors1 SET experience = 20 WHERE department = 'Electronics';

-- 8. Set qualification to MTech where experience < 10
UPDATE Professors1 SET qualification = 'MTech' WHERE experience < 10;

-- 9. Add " (Updated)" to names of Mechanical professors
UPDATE Professors1 SET name = CONCAT(name, ' (Updated)') WHERE department = 'Mechanical';

-- 10. Set experience to 0 for professors from Physics
UPDATE Professors1 SET experience = 0 WHERE department = 'Physics';

-- 11. Update all emails to lowercase
UPDATE Professors1 SET email = LOWER(email);

-- 12. Change department of Dr. Bhat to Civil
UPDATE Professors1 SET department = 'Civil' WHERE name LIKE '%Bhat%';

-- 13. Set experience to 30 for Dr. Nair
UPDATE Professors1 SET experience = 30 WHERE name = 'Dr. Nair';

-- 14. Reset experience of Dr. Mehta to 15
UPDATE Professors1 SET experience = 15 WHERE name = 'Dr. Mehta';

-- 15. Update department of Dr. Sen to Applied Math
UPDATE Professors1 SET department = 'Applied Math' WHERE name = 'Dr. S. Sen';

-- 16. Change qualification of all CS professors to MSc
UPDATE Professors1 SET qualification = 'MSc' WHERE department = 'CS';

-- 17. Prefix "Prof." to all names
UPDATE Professors1 SET name = CONCAT('Prof. ', name);

-- 18. Update department for ID 3 to Stats
UPDATE Professors1 SET department = 'Stats' WHERE professor_id = 3;

-- 19. Set email domain to profs.univ.edu
UPDATE Professors1 SET email = CONCAT(SUBSTRING(email, 1, LOCATE('@', email) - 1), '@profs.univ.edu');

-- 20. Remove title from names
UPDATE Professors1 SET name = REPLACE(name, 'Prof. Dr. ', '');


-- 20 delete queries
-- 1. Delete professor with ID 10
DELETE FROM Professors1 WHERE professor_id = 10;

-- 2. Delete all professors from Physics
DELETE FROM Professors1 WHERE department = 'Physics';

-- 3. Delete professors with less than 10 years experience
DELETE FROM Professors1 WHERE experience < 10;

-- 4. Delete professors with qualification MTech
DELETE FROM Professors1 WHERE qualification = 'MTech';

-- 5. Delete professors from Mechanical department
DELETE FROM Professors1 WHERE department = 'Mechanical';

-- 6. Delete professor with name 'Dr. Rao'
DELETE FROM Professors1 WHERE name = 'Dr. Rao';

-- 7. Delete all professors whose email contains 'univ'
DELETE FROM Professors1 WHERE email LIKE '%univ%';

-- 8. Delete professors with experience over 25
DELETE FROM Professors1 WHERE experience > 25;

-- 9. Delete all professors in department 'Stats'
DELETE FROM Professors1 WHERE department = 'Stats';

-- 10. Delete all with NULL email
DELETE FROM Professors1 WHERE email IS NULL;

-- 11. Delete professors from CS department
DELETE FROM Professors1 WHERE department = 'CS';

-- 12. Delete all with PhD qualification
DELETE FROM Professors1 WHERE qualification = 'PhD';

-- 13. Delete professors with ID between 1 and 5
DELETE FROM Professors1 WHERE professor_id BETWEEN 1 AND 5;

-- 14. Delete professors whose name contains 'Kapoor'
DELETE FROM Professors1 WHERE name LIKE '%Kapoor%';

-- 15. Delete professors with name starting with 'Prof.'
DELETE FROM Professors1 WHERE name LIKE 'Prof.%';

-- 16. Delete professors with name ending in '(Updated)'
DELETE FROM Professors1 WHERE name LIKE '%(Updated)';

-- 17. Delete all professors
DELETE FROM Professors1;

-- 18. Delete based on email domain
DELETE FROM Professors1 WHERE email LIKE '%@profs.univ.edu';

-- 19. Delete professors with ID > 5
DELETE FROM Professors1 WHERE professor_id > 5;

-- 20. Delete professors with ID not in (1,2,3)
DELETE FROM Professors1 WHERE professor_id NOT IN (1,2,3);

-- TABLE-4
CREATE TABLE Departments1 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    head VARCHAR(50),
    faculty_count INT,
    building VARCHAR(30),
    established_year INT
);

INSERT INTO Departments1 VALUES
(1, 'Computer Science', 'Dr. Mehta', 25, 'Block A', 1990),
(2, 'Mechanical', 'Dr. Iyer', 30, 'Block B', 1985),
(3, 'Mathematics', 'Dr. Sen', 20, 'Block C', 1980),
(4, 'Physics', 'Dr. Raina', 22, 'Block D', 1975),
(5, 'Electronics', 'Dr. Rao', 18, 'Block E', 1995),
(6, 'Civil', 'Dr. Prasad', 15, 'Block F', 1982),
(7, 'Biotech', 'Dr. Kiran', 12, 'Block G', 2000),
(8, 'Chemistry', 'Dr. Naidu', 17, 'Block H', 1988),
(9, 'Humanities', 'Dr. Deshmukh', 10, 'Block I', 1991),
(10, 'Env. Science', 'Dr. Kothari', 11, 'Block J', 1998);

-- to display table data
select * from Departments1;

-- to remove complete records from table
truncate table Departments1;

-- to remove complete records and attributes from table
drop table Departments1;

-- 20 select queries
-- 1. Select all departments
SELECT * FROM Departments1;

-- 2. Select only department names
SELECT dept_name FROM Departments1;

-- 3. Departments established before 1990
SELECT * FROM Departments1 WHERE established_year < 1990;

-- 4. Departments with faculty count > 20
SELECT * FROM Departments1 WHERE faculty_count > 20;

-- 5. Departments in Block A or Block B
SELECT * FROM Departments1 WHERE building IN ('Block A', 'Block B');

-- 6. Departments headed by 'Dr. Mehta'
SELECT * FROM Departments1 WHERE head = 'Dr. Mehta';

-- 7. List all unique buildings
SELECT DISTINCT building FROM Departments1;

-- 8. Order departments by established year
SELECT * FROM Departments1 ORDER BY established_year ASC;

-- 9. Departments with names starting with 'C'
SELECT * FROM Departments1 WHERE dept_name LIKE 'C%';

-- 10. Count total departments
SELECT COUNT(*) FROM Departments1;

-- 11. Average faculty count
SELECT AVG(faculty_count) FROM Departments1;

-- 12. Departments with faculty count between 10 and 20
SELECT * FROM Departments1 WHERE faculty_count BETWEEN 10 AND 20;

-- 13. Find department with max faculty
SELECT * FROM Departments1 ORDER BY faculty_count DESC LIMIT 1;

-- 14. Total faculty in the university
SELECT SUM(faculty_count) AS total_faculty FROM Departments1;

-- 15. Departments not in Block A
SELECT * FROM Departments1 WHERE building <> 'Block A';

-- 16. Departments established after 1995
SELECT * FROM Departments1 WHERE established_year > 1995;

-- 17. Departments with even faculty count
SELECT * FROM Departments1 WHERE faculty_count % 2 = 0;

-- 18. Department names and their heads
SELECT dept_name, head FROM Departments1;

-- 19. Departments where head's name contains 'Dr.'
SELECT * FROM Departments1 WHERE head LIKE '%Dr.%';

-- 20. Rename dept_id as 'ID'
SELECT dept_id AS ID, dept_name FROM Departments1;


-- 20 alter queries
-- 1. Add a column for department email
ALTER TABLE Departments1 ADD email VARCHAR(100);

-- 2. Add phone number column
ALTER TABLE Departments1 ADD phone VARCHAR(15);

-- 3. Rename column faculty_count to total_faculty
ALTER TABLE Departments1 RENAME COLUMN faculty_count TO total_faculty;

-- 4. Change data type of building
ALTER TABLE Departments1 ALTER COLUMN building TYPE VARCHAR(50);

-- 5. Drop the phone column
ALTER TABLE Departments1 DROP COLUMN phone;

-- 6. Rename dept_name to department_name
ALTER TABLE Departments1 RENAME COLUMN dept_name TO department_name;

-- 7. Add accreditation_year column
ALTER TABLE Departments1 ADD accreditation_year INT;

-- 8. Set default value for accreditation_year
ALTER TABLE Departments1 ALTER COLUMN accreditation_year SET DEFAULT 2000;

-- 9. Add column is_active
ALTER TABLE Departments1 ADD is_active BOOLEAN DEFAULT TRUE;

-- 10. Drop accreditation_year
ALTER TABLE Departments1 DROP COLUMN accreditation_year;

-- 11. Rename table to Departments
ALTER TABLE Departments1 RENAME TO Departments;

-- 12. Add constraint for established_year > 1900
ALTER TABLE Departments ADD CONSTRAINT chk_year CHECK (established_year > 1900);

-- 13. Modify total_faculty to NOT NULL
ALTER TABLE Departments ALTER COLUMN total_faculty SET NOT NULL;

-- 14. Add unique constraint to department_name
ALTER TABLE Departments ADD CONSTRAINT uniq_name UNIQUE (department_name);

-- 15. Drop is_active column
ALTER TABLE Departments DROP COLUMN is_active;

-- 16. Add column department_code
ALTER TABLE Departments ADD department_code VARCHAR(10);

-- 17. Set department_code default value
ALTER TABLE Departments ALTER COLUMN department_code SET DEFAULT 'NA';

-- 18. Drop email column
ALTER TABLE Departments DROP COLUMN email;

-- 19. Rename head column to hod
ALTER TABLE Departments RENAME COLUMN head TO hod;

-- 20. Add a foreign key column university_id (assume Universities table exists)
ALTER TABLE Departments ADD university_id INT;


-- 20 update queries
-- 1. Update head of Computer Science
UPDATE Departments SET hod = 'Dr. Verma' WHERE department_name = 'Computer Science';

-- 2. Increase faculty by 5 in Mechanical
UPDATE Departments SET total_faculty = total_faculty + 5 WHERE department_name = 'Mechanical';

-- 3. Change building for Physics to Block Z
UPDATE Departments SET building = 'Block Z' WHERE department_name = 'Physics';

-- 4. Set department_code for Electronics
UPDATE Departments SET department_code = 'ELE' WHERE department_name = 'Electronics';

-- 5. Set all buildings to uppercase
UPDATE Departments SET building = UPPER(building);

-- 6. Change HOD of Humanities
UPDATE Departments SET hod = 'Dr. Pillai' WHERE department_name = 'Humanities';

-- 7. Set university_id = 1 for all
UPDATE Departments SET university_id = 1;

-- 8. Increase faculty of all by 2
UPDATE Departments SET total_faculty = total_faculty + 2;

-- 9. Reduce Civil faculty to 10
UPDATE Departments SET total_faculty = 10 WHERE department_name = 'Civil';

-- 10. Nullify HOD of Chemistry
UPDATE Departments SET hod = NULL WHERE department_name = 'Chemistry';

-- 11. Set dept_code to short name
UPDATE Departments SET department_code = LEFT(department_name, 3);

-- 12. Set HOD to 'TBD' if NULL
UPDATE Departments SET hod = 'TBD' WHERE hod IS NULL;

-- 13. Set building to 'Online' for Env. Science
UPDATE Departments SET building = 'Online' WHERE department_name = 'Env. Science';

-- 14. Set all dept codes to lowercase
UPDATE Departments SET department_code = LOWER(department_code);

-- 15. Assign dept_code for Mathematics
UPDATE Departments SET department_code = 'MATH' WHERE department_name = 'Mathematics';

-- 16. Increase faculty by 1 for all in Block A
UPDATE Departments SET total_faculty = total_faculty + 1 WHERE building = 'BLOCK A';

-- 17. Change established year of Biotech
UPDATE Departments SET established_year = 2005 WHERE department_name = 'Biotech';

-- 18. Set department_code = 'CS' for Computer Science
UPDATE Departments SET department_code = 'CS' WHERE department_name = 'Computer Science';

-- 19. Increase established_year by 1 for all
UPDATE Departments SET established_year = established_year + 1;

-- 20. Set department_code = NULL where total_faculty < 15
UPDATE Departments SET department_code = NULL WHERE total_faculty < 15;


-- 20 delete queries
-- 1. Delete department with ID 10
DELETE FROM Departments WHERE dept_id = 10;

-- 2. Delete departments with faculty less than 12
DELETE FROM Departments WHERE total_faculty < 12;

-- 3. Delete department 'Humanities'
DELETE FROM Departments WHERE department_name = 'Humanities';

-- 4. Delete all departments in 'Block I'
DELETE FROM Departments WHERE building = 'BLOCK I';

-- 5. Delete department by HOD name
DELETE FROM Departments WHERE hod = 'Dr. Sen';

-- 6. Delete departments established after 2000
DELETE FROM Departments WHERE established_year > 2000;

-- 7. Delete department with null HOD
DELETE FROM Departments WHERE hod IS NULL;

-- 8. Delete department named 'Civil'
DELETE FROM Departments WHERE department_name = 'Civil';

-- 9. Delete departments with dept_code NULL
DELETE FROM Departments WHERE department_code IS NULL;

-- 10. Delete all departments temporarily (not recommended in prod)
-- DELETE FROM Departments;

-- 11. Delete department with max faculty
DELETE FROM Departments WHERE total_faculty = (SELECT MAX(total_faculty) FROM Departments);

-- 12. Delete oldest department
DELETE FROM Departments WHERE established_year = (SELECT MIN(established_year) FROM Departments);

-- 13. Delete department in 'Online' building
DELETE FROM Departments WHERE building = 'ONLINE';

-- 14. Delete department where dept_code = 'CS'
DELETE FROM Departments WHERE department_code = 'CS';

-- 15. Delete all departments in Block B
DELETE FROM Departments WHERE building = 'BLOCK B';

-- 16. Delete department with id = 3
DELETE FROM Departments WHERE dept_id = 3;

-- 17. Delete departments with even ID
DELETE FROM Departments WHERE dept_id % 2 = 0;

-- 18. Delete all departments where faculty is exactly 17
DELETE FROM Departments WHERE total_faculty = 17;

-- 19. Delete departments with names starting with 'B'
DELETE FROM Departments WHERE department_name LIKE 'B%';

-- 20. Delete all departments with NULL department_code
DELETE FROM Departments WHERE department_code IS NULL;



-- TABLE-5
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    course_applied VARCHAR(50),
    admission_date DATE,
    status VARCHAR(20),
    fee_paid BOOLEAN
);

INSERT INTO Admissions VALUES
(1001, 'Amit Kumar', 'Computer Science', '2025-06-01', 'Confirmed', TRUE),
(1002, 'Sara Khan', 'Mechanical', '2025-06-02', 'Pending', FALSE),
(1003, 'John Das', 'Mathematics', '2025-06-03', 'Confirmed', TRUE),
(1004, 'Priya Verma', 'Physics', '2025-06-04', 'Rejected', FALSE),
(1005, 'Ravi Singh', 'Electronics', '2025-06-05', 'Confirmed', TRUE),
(1006, 'Simran Kaur', 'Computer Science', '2025-06-06', 'Pending', FALSE),
(1007, 'David Roy', 'Physics', '2025-06-07', 'Confirmed', TRUE),
(1008, 'Neha Gupta', 'Mathematics', '2025-06-08', 'Confirmed', TRUE),
(1009, 'Arjun Reddy', 'Mechanical', '2025-06-09', 'Rejected', FALSE),
(1010, 'Pooja Jain', 'Electronics', '2025-06-10', 'Confirmed', TRUE);

-- to display table data
select * from Admissions;

-- to remove complete records from table
truncate table Admissions;

-- to remove complete records and attributes from table
drop table Admissions;

-- 20 select queries
-- 1. Select all records
SELECT * FROM Admissions;

-- 2. Select students who paid the fee
SELECT * FROM Admissions WHERE fee_paid = TRUE;

-- 3. Select confirmed admissions
SELECT * FROM Admissions WHERE status = 'Confirmed';

-- 4. Get distinct courses applied
SELECT DISTINCT course_applied FROM Admissions;

-- 5. List students who applied for 'Physics'
SELECT student_name FROM Admissions WHERE course_applied = 'Physics';

-- 6. Count total admissions
SELECT COUNT(*) FROM Admissions;

-- 7. Count pending applications
SELECT COUNT(*) FROM Admissions WHERE status = 'Pending';

-- 8. List students who haven't paid the fee
SELECT * FROM Admissions WHERE fee_paid = FALSE;

-- 9. Admissions between 2025-06-03 and 2025-06-07
SELECT * FROM Admissions WHERE admission_date BETWEEN '2025-06-03' AND '2025-06-07';

-- 10. Admissions ordered by date
SELECT * FROM Admissions ORDER BY admission_date;

-- 11. Students who applied for 'Computer Science' and paid
SELECT * FROM Admissions WHERE course_applied = 'Computer Science' AND fee_paid = TRUE;

-- 12. Admissions with status either 'Pending' or 'Rejected'
SELECT * FROM Admissions WHERE status IN ('Pending', 'Rejected');

-- 13. Students whose name starts with 'P'
SELECT * FROM Admissions WHERE student_name LIKE 'P%';

-- 14. Get course-wise count of students
SELECT course_applied, COUNT(*) FROM Admissions GROUP BY course_applied;

-- 15. Get only names and course of confirmed admissions
SELECT student_name, course_applied FROM Admissions WHERE status = 'Confirmed';

-- 16. Check if any admission is on '2025-06-08'
SELECT * FROM Admissions WHERE admission_date = '2025-06-08';

-- 17. Select admissions where fee_paid is not null
SELECT * FROM Admissions WHERE fee_paid IS NOT NULL;

-- 18. Find latest admission
SELECT * FROM Admissions ORDER BY admission_date DESC LIMIT 1;

-- 19. Admissions where student name contains 'a'
SELECT * FROM Admissions WHERE student_name LIKE '%a%';

-- 20. Alias column names
SELECT admission_id AS ID, student_name AS Name, status AS Admission_Status FROM Admissions;


-- 20 alter queries
-- 1. Add column email
ALTER TABLE Admissions ADD email VARCHAR(100);

-- 2. Add phone number
ALTER TABLE Admissions ADD phone VARCHAR(15);

-- 3. Rename course_applied to course
ALTER TABLE Admissions RENAME COLUMN course_applied TO course;

-- 4. Add column counselor_assigned
ALTER TABLE Admissions ADD counselor_assigned VARCHAR(50);

-- 5. Add default value to status
ALTER TABLE Admissions ALTER COLUMN status SET DEFAULT 'Pending';

-- 6. Set NOT NULL constraint on student_name
ALTER TABLE Admissions ALTER COLUMN student_name SET NOT NULL;

-- 7. Drop phone column
ALTER TABLE Admissions DROP COLUMN phone;

-- 8. Rename table to StudentAdmissions
ALTER TABLE Admissions RENAME TO StudentAdmissions;

-- 9. Add scholarship_eligible column
ALTER TABLE StudentAdmissions ADD scholarship_eligible BOOLEAN DEFAULT FALSE;

-- 10. Drop column email
ALTER TABLE StudentAdmissions DROP COLUMN email;

-- 11. Change data type of counselor_assigned
ALTER TABLE StudentAdmissions ALTER COLUMN counselor_assigned TYPE VARCHAR(100);

-- 12. Add constraint for admission_id > 1000
ALTER TABLE StudentAdmissions ADD CONSTRAINT chk_admission_id CHECK (admission_id > 1000);

-- 13. Make fee_paid default FALSE
ALTER TABLE StudentAdmissions ALTER COLUMN fee_paid SET DEFAULT FALSE;

-- 14. Drop column counselor_assigned
ALTER TABLE StudentAdmissions DROP COLUMN counselor_assigned;

-- 15. Rename column status to admission_status
ALTER TABLE StudentAdmissions RENAME COLUMN status TO admission_status;

-- 16. Add admission_year column
ALTER TABLE StudentAdmissions ADD admission_year INT;

-- 17. Drop scholarship_eligible column
ALTER TABLE StudentAdmissions DROP COLUMN scholarship_eligible;

-- 18. Rename student_name to full_name
ALTER TABLE StudentAdmissions RENAME COLUMN student_name TO full_name;

-- 19. Add column remarks
ALTER TABLE StudentAdmissions ADD remarks TEXT;

-- 20. Drop column remarks
ALTER TABLE StudentAdmissions DROP COLUMN remarks;


-- 20 update queries
-- 1. Update status to Confirmed for Amit Kumar
UPDATE StudentAdmissions SET admission_status = 'Confirmed' WHERE full_name = 'Amit Kumar';

-- 2. Mark all pending students as Rejected
UPDATE StudentAdmissions SET admission_status = 'Rejected' WHERE admission_status = 'Pending';

-- 3. Change course for Neha Gupta
UPDATE StudentAdmissions SET course = 'Physics' WHERE full_name = 'Neha Gupta';

-- 4. Set admission_year based on admission_date
UPDATE StudentAdmissions SET admission_year = EXTRACT(YEAR FROM admission_date);

-- 5. Set fee_paid to TRUE where status is Confirmed
UPDATE StudentAdmissions SET fee_paid = TRUE WHERE admission_status = 'Confirmed';

-- 6. Update name from John Das to John D.
UPDATE StudentAdmissions SET full_name = 'John D.' WHERE full_name = 'John Das';

-- 7. Assign admission_year = 2025 to all
UPDATE StudentAdmissions SET admission_year = 2025;

-- 8. Change status of Arjun Reddy to Pending
UPDATE StudentAdmissions SET admission_status = 'Pending' WHERE full_name = 'Arjun Reddy';

-- 9. Update all names to uppercase
UPDATE StudentAdmissions SET full_name = UPPER(full_name);

-- 10. Set course to NULL for Rejected students
UPDATE StudentAdmissions SET course = NULL WHERE admission_status = 'Rejected';

-- 11. Set default admission_year if NULL
UPDATE StudentAdmissions SET admission_year = 2025 WHERE admission_year IS NULL;

-- 12. Mark students with Electronics as scholarship eligible
ALTER TABLE StudentAdmissions ADD scholarship_eligible BOOLEAN DEFAULT FALSE;
UPDATE StudentAdmissions SET scholarship_eligible = TRUE WHERE course = 'Electronics';

-- 13. Append ' (Updated)' to all names
UPDATE StudentAdmissions SET full_name = CONCAT(full_name, ' (Updated)');

-- 14. Reset names by removing '(Updated)'
UPDATE StudentAdmissions SET full_name = REPLACE(full_name, ' (Updated)', '');

-- 15. Mark all students in June as Confirmed
UPDATE StudentAdmissions SET admission_status = 'Confirmed'
WHERE admission_date BETWEEN '2025-06-01' AND '2025-06-30';

-- 16. Change status of Pooja Jain to Pending
UPDATE StudentAdmissions SET admission_status = 'Pending' WHERE full_name = 'Pooja Jain';

-- 17. Set admission_year to 2026 for rejected students
UPDATE StudentAdmissions SET admission_year = 2026 WHERE admission_status = 'Rejected';

-- 18. Assign course 'General' to NULL course fields
UPDATE StudentAdmissions SET course = 'General' WHERE course IS NULL;

-- 19. Assign name 'Unknown' to any NULL full_name
UPDATE StudentAdmissions SET full_name = 'Unknown' WHERE full_name IS NULL;

-- 20. Reverse all names
 UPDATE StudentAdmissions SET full_name = REVERSE(full_name);

-- 20 delete queries
-- 1. Delete rejected applications
DELETE FROM StudentAdmissions WHERE admission_status = 'Rejected';

-- 2. Delete records where fee not paid
DELETE FROM StudentAdmissions WHERE fee_paid = FALSE;

-- 3. Delete student 'Ravi Singh'
DELETE FROM StudentAdmissions WHERE full_name = 'Ravi Singh';

-- 4. Delete admissions for 'Mathematics'
DELETE FROM StudentAdmissions WHERE course = 'Mathematics';

-- 5. Delete all students with NULL course
DELETE FROM StudentAdmissions WHERE course IS NULL;

-- 6. Delete one admission by ID
DELETE FROM StudentAdmissions WHERE admission_id = 1002;

-- 7. Delete oldest admission
DELETE FROM StudentAdmissions WHERE admission_date = (SELECT MIN(admission_date) FROM StudentAdmissions);

-- 8. Delete admissions from '2025-06-10'
DELETE FROM StudentAdmissions WHERE admission_date = '2025-06-10';

-- 9. Delete all pending students
DELETE FROM StudentAdmissions WHERE admission_status = 'Pending';

-- 10. Delete students with names starting with 'D'
DELETE FROM StudentAdmissions WHERE full_name LIKE 'D%';

-- 11. Delete where full_name is NULL
DELETE FROM StudentAdmissions WHERE full_name IS NULL;

-- 12. Delete all except 'Computer Science'
DELETE FROM StudentAdmissions WHERE course <> 'Computer Science';

-- 13. Delete all confirmed admissions
DELETE FROM StudentAdmissions WHERE admission_status = 'Confirmed';

-- 14. Delete where admission_year = 2026
DELETE FROM StudentAdmissions WHERE admission_year = 2026;

-- 15. Delete student with name 'Neha Gupta'
DELETE FROM StudentAdmissions WHERE full_name = 'Neha Gupta';

-- 16. Delete last 2 records (PostgreSQL way)
DELETE FROM StudentAdmissions WHERE admission_id IN (
    SELECT admission_id FROM StudentAdmissions ORDER BY admission_id DESC LIMIT 2
);

-- 17. Delete students not applied for any course
DELETE FROM StudentAdmissions WHERE course IS NULL;

-- 18. Delete admissions on weekends (example logic)
DELETE FROM StudentAdmissions WHERE EXTRACT(DOW FROM admission_date) IN (0, 6);

-- 19. Delete students without scholarship eligibility
DELETE FROM StudentAdmissions WHERE scholarship_eligible = FALSE;

-- 20. Delete entire table data
-- DELETE FROM StudentAdmissions;
