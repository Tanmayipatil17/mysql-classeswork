create database company;
use company;
drop database company;

-- Part A: Commands (DDL, DML, DQL)

-- Q1. Create Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Email VARCHAR(100)
);

INSERT INTO Employees (EmpID, Name, Department, Salary, Email) VALUES
(101, 'Rohit Sharma', 'Finance', 90000, 'rohit@company.com'),
(102, 'Anjali Verma', 'HR', 60000, 'anjali@company.com'),
(103, 'Vikram Singh', 'IT', 75000, 'vikram@company.com'),
(104, 'Priya Kapoor', 'Finance', 82000, 'priya@company.com'),
(105, 'Amit Kumar', 'IT', 70000, 'amit@company.com');

-- Q2. Update salary of employee with EmpID = 105
UPDATE Employees
SET Salary = 75000
WHERE EmpID = 105;

-- Q3. Delete employees from HR department
DELETE FROM Employees
WHERE Department = 'HR';

-- Q4. Select employees in Finance department
SELECT *
FROM Employees
WHERE Department = 'Finance';

-- Part B: Clauses

-- Q5. Top 3 highest-paid employees
SELECT *
FROM Employees
ORDER BY Salary DESC
LIMIT 3;

-- Q6. Total salary by department
SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department;

-- Q7. Employees earning between 50,000 and 80,000
SELECT *
FROM Employees
WHERE Salary > 50000 AND Salary < 80000;

-- Q8. Employees whose names start with 'A'
SELECT *
FROM Employees
WHERE Name LIKE 'A%';

-- Part C: Constraints

-- Q9. Students table (unique RollNo, Marks >= 0)
CREATE TABLE Students (
    RollNo INT UNIQUE,
    Name VARCHAR(100),
    Marks INT CHECK (Marks >= 0)
);

-- Q10. Add NOT NULL constraint on Email in Employees
ALTER TABLE Employees
MODIFY Email VARCHAR(100) NOT NULL;

-- Q11. Orders table with Foreign Key
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Part D: Joins

-- Q12. Customer names with their orders
SELECT c.CustomerName, o.OrderID, o.Amount
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID;

-- Q13. Employees with projects (show even if no project)
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    EmpID INT,
    ProjectName VARCHAR(100)
);

SELECT e.Name, p.ProjectName
FROM Employees e
LEFT JOIN Projects p
    ON e.EmpID = p.EmpID;

-- Q14. Departments with employees (show departments without employees)
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

SELECT d.DepartmentName, e.Name
FROM Employees e
RIGHT JOIN Departments d
    ON e.Department = d.DepartmentName;

-- Q15. Employees with no project assigned
SELECT e.Name
FROM Employees e
LEFT JOIN Projects p
    ON e.EmpID = p.EmpID
WHERE p.ProjectID IS NULL;

-- Q16. Combine Branch_A and Branch_B employees
CREATE TABLE Branch_A_Employees (
    EmpID INT,
    Name VARCHAR(100)
);

CREATE TABLE Branch_B_Employees (
    EmpID INT,
    Name VARCHAR(100)
);

SELECT EmpID, Name FROM Branch_A_Employees
UNION
SELECT EmpID, Name FROM Branch_B_Employees;

-- Part E: Subqueries

-- Q17. Second highest salary
SELECT MAX(Salary) AS SecondHighest
FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

-- Q18. Employees with salary greater than average
SELECT Name, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Q19. Employees in same department as 'Rohit'
SELECT *
FROM Employees
WHERE Department = (
    SELECT Department
    FROM Employees
    WHERE Name = 'Rohit'
);

-- Q20. Customers with orders more than average
SELECT CustomerID, SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
HAVING SUM(Amount) > (
    SELECT AVG(Amount) FROM Orders
);

-- Part E:  Built-in & User-defined Functions

-- Q21. Use a built-in function to display the current date and time.
-- In MySQL
SELECT NOW() AS CurrentDateTime;

-- In SQL Server
SELECT GETDATE() AS CurrentDateTime;

-- In Oracle
SELECT SYSDATE AS CurrentDateTime FROM dual;

-- Q22. Write a query to show the length of each employee’s name using the LENGTH() function.
SELECT EmpID, Name, LENGTH(Name) AS NameLength
FROM Employees;

-- Q24. Retrieve the total number of employees in the company using a built-in function.
SELECT COUNT(*) AS TotalEmployees
FROM Employees;

-- Q25. Create a user-defined function GetBonus(salary) that returns 10% of the salary as a bonus.
SELECT EmpID, Name, GetBonus(Salary) AS Bonus
FROM Employees;
