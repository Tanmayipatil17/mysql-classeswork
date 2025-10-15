-- -----------------------------------------------------------------------Analysis of Database---------------------------------------------------------------------------------------------------------------
/*
Database Name --> Viviana Mall

Tables --> 
  
 Table 1:  Shop (shopID, shopName, category, Floor, contactNumber)
 Table 2: Employees (EmployeeID, Name, Post, ShopID, Salary) 
 Table 3: Products(ProductID, ProductName, Category, Price, ShopID) 
 Table 4: Customers(CustomerID, Name, Gender, Phone, Email) 
 Table 5: Sales(SaleID, ProductID,CustomerID, Quantity, SaleDate) 

*/

-- Create a database viviana_mall;
CREATE DATABASE viviana_mall;

-- to work on database you have to need use it first
USE viviana_mall;

-- Table 1: Shop 
CREATE TABLE Shops (
    ShopID INT PRIMARY KEY,
    ShopName VARCHAR(100),
    Category VARCHAR(50),
    Floor INT,
    ContactNumber VARCHAR(15)
);

INSERT INTO Shops (shopID, shopName, category, Floor, contactNumber) VALUES
(1, 'Zara', 'Clothing', 1, '9876543210'),
(2, 'Nike', 'Footwear', 2, '8765432109'),
(3, 'H&M', 'Clothing', 1, '7654321098'),
(4, 'Samsung', 'Electronics', 3, '6543210987'),
(5, 'Vivo', 'Electronics', 2, '5432109876'),
(6, 'Biba', 'Ethnic Wear', 1, '4321098765'),
(7, 'Apple Store', 'Electronics', 3, '3210987654'),
(8, 'Levi’s', 'Denim', 2, '2109876543'),
(9, 'Croma', 'Electronics', 3, '1098765432'),
(10, 'Bugrger King', 'Food section', 1, '1987654321');

-- to display all table data
SELECT * FROM Shops;

-- to remove complete records from table
TRUNCATE TABLE Shops;

-- to remove complete records and attributes from table
DROP TABLE Shops;

--  Insert new shop (DML)
INSERT INTO Shops VALUES (11, 'Decathlon', 'Sports', 2, '7000000001');

--  Update shop category (DML)
UPDATE Shops SET Category = 'Lifestyle' WHERE ShopName = 'Zara';

--  Delete a shop (DML)
DELETE FROM Shops WHERE ShopID = 11;

-- SELECT shops on floor 2 (DQL + WHERE)
SELECT * FROM Shops WHERE Floor = 2;

-- SELECT using ORDER BY clause
SELECT * FROM Shops ORDER BY ShopName ASC;

--  SELECT top 5 shops (LIMIT clause)
SELECT * FROM Shops LIMIT 5;

-- SELECT unique categories (DISTINCT)
SELECT DISTINCT Category FROM Shops;

-- COUNT total shops (AGGREGATE + GROUP BY)
SELECT Floor, COUNT(*) AS TotalShops FROM Shops GROUP BY Floor;

-- RENAME table (DDL)
ALTER TABLE Shops RENAME TO MallShops;

-- Add column to track area (DDL)
ALTER TABLE MallShops ADD Area VARCHAR(50);


--  Use of BETWEEN
SELECT * FROM MallShops WHERE Floor BETWEEN 1 AND 2;

-- SELECT with alias
SELECT ShopName AS 'Store', Category AS 'Type' FROM MallShops;

--  Use of LIKE operator
SELECT * FROM MallShops WHERE ShopName LIKE '%Store%';

-- Use of IN
SELECT * FROM MallShops WHERE Category IN ('Electronics', 'Clothing');

--  LENGTH function
SELECT ShopName, LENGTH(ShopName) AS NameLength FROM MallShops;

-- UPPER function
SELECT UPPER(ShopName) AS CapitalName FROM MallShops;

--  CONCAT shop name and category
SELECT CONCAT(ShopName, ' - ', Category) AS FullDetails FROM MallShops;

-- CASE for labeling
SELECT ShopName,
  CASE
    WHEN Floor = 1 THEN 'Ground Level'
    WHEN Floor = 2 THEN 'Mid Level'
    ELSE 'Top Level'
  END AS Location
FROM MallShops;

-- Use of IS NULL
SELECT * FROM MallShops WHERE Area IS NULL;

-- Use of COALESCE
SELECT ShopName, COALESCE(Area, 'Unknown') AS ShopArea FROM MallShops;

-- Rollback an insert (TCL)
START TRANSACTION;
INSERT INTO MallShops VALUES (12, 'New Shop', 'Test', 4, '9999999999', 'Zone C');
ROLLBACK;

--  Commit transaction (TCL)
START TRANSACTION;
UPDATE MallShops SET Floor = 1 WHERE ShopID = 6;
COMMIT;

-- Grant select permission (DCL)
GRANT SELECT ON Viviana_Mall.MallShops TO 'readonly_user'@'localhost';

--  Revoke update permission (DCL)
REVOKE UPDATE ON MallShops FROM 'readonly_user';

--  Subquery: List shops in highest floor
SELECT * FROM MallShops WHERE Floor = (SELECT MAX(Floor) FROM MallShops);

-- Subquery with EXISTS
SELECT ShopName FROM MallShops WHERE EXISTS (
  SELECT 1 FROM MallShops WHERE Category = 'Electronics'
);

-- Create view for electronics shops
CREATE VIEW ElectronicsShops AS
SELECT ShopID, ShopName FROM MallShops WHERE Category = 'Electronics';

-- SELECT from view
SELECT * FROM ElectronicsShops;

-- WITH CTE to calculate shop count per category
WITH CategoryCount AS (
  SELECT Category, COUNT(*) AS Total FROM MallShops GROUP BY Category
)
SELECT * FROM CategoryCount;

-- JOIN (Shops + Employees simulated example)
-- Assuming another table 'Employees' exists with ShopID foreign key
SELECT s.ShopName, e.Name AS EmployeeName
FROM MallShops s
JOIN Employees e ON s.ShopID = e.ShopID;

--  LEFT JOIN with alias
SELECT s.ShopName, e.Name AS Staff
FROM MallShops s
LEFT JOIN Employees e ON s.ShopID = e.ShopID;

-- JOIN with aggregation
SELECT s.ShopName, COUNT(e.EmployeeID) AS TotalStaff
FROM MallShops s
LEFT JOIN Employees e ON s.ShopID = e.ShopID
GROUP BY s.ShopName;

-- Create function to return shop floor
DELIMITER $$
CREATE FUNCTION GetShopFloor(shop_name VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE f INT;
  SELECT Floor INTO f FROM MallShops WHERE ShopName = shop_name LIMIT 1;
  RETURN f;
END $$
DELIMITER ;

-- Call user-defined function
SELECT GetShopFloor('Zara') AS ZaraFloor;

-- Stored Procedure to update contact number
DELIMITER $$
CREATE PROCEDURE UpdateContact(IN shop INT, IN newContact VARCHAR(15))
BEGIN
  UPDATE MallShops SET ContactNumber = newContact WHERE ShopID = shop;
END $$
DELIMITER ;

-- Call stored procedure
CALL UpdateContact(3, '9999998888');

-- Procedure to return shops on floor
DELIMITER $$
CREATE PROCEDURE ShopsOnFloor(IN fl INT)
BEGIN
  SELECT * FROM MallShops WHERE Floor = fl;
END $$
DELIMITER ;

--  Call procedure
CALL ShopsOnFloor(2);

--  Get shops with more than 2 employees (assuming JOIN)
SELECT s.ShopName
FROM MallShops s
JOIN Employees e ON s.ShopID = e.ShopID
GROUP BY s.ShopName
HAVING COUNT(e.EmployeeID) > 2;

--  Replace all ‘Electronics’ category to ‘Tech’
UPDATE MallShops SET Category = 'Tech' WHERE Category = 'Electronics';

-- Generate report with ranking
SELECT ShopName, Category,
  RANK() OVER (PARTITION BY Category ORDER BY ShopName ASC) AS RankInCategory
FROM MallShops;

-- Find duplicate contact numbers
SELECT ContactNumber, COUNT(*) AS Count
FROM MallShops
GROUP BY ContactNumber
HAVING COUNT(*) > 1;

-- Calculate floor density (shop count per floor)
SELECT Floor, COUNT(*) AS ShopCount FROM MallShops GROUP BY Floor;

--  View with shops starting with ‘S’
CREATE VIEW SShops AS SELECT * FROM MallShops WHERE ShopName LIKE 'S%';

--  Longest shop name
SELECT ShopName FROM MallShops ORDER BY LENGTH(ShopName) DESC LIMIT 1;

-- Mask contact numbers (show only last 4 digits)
SELECT ShopName,
  CONCAT('XXXXXXX', RIGHT(ContactNumber, 4)) AS MaskedContact
FROM MallShops;

--  Delete shops with NULL area (cleanup)
DELETE FROM MallShops WHERE Area IS NULL;

-- Backup table
CREATE TABLE Shops_Backup AS SELECT * FROM MallShops;

--  Drop view and restore shop table
DROP VIEW IF EXISTS SShops;
RENAME TABLE Shops_Backup TO Shops;


-- Table 2: Employees 
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Post VARCHAR(50),
    ShopID INT,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Post, ShopID, Salary) VALUES
(1, 'Riya Sharma', 'Manager', 1, 35000.00),
(2, 'Amit Patel', 'Salesman', 2, 20000.00),
(3, 'Sneha Rao', 'Cashier', 3, 22000.00),
(4, 'Vikram Singh', 'Technician', 4, 28000.00),
(5, 'Neha Joshi', 'Sales Executive', 5, 24000.00),
(6, 'Aditya Mehta', 'Store Keeper', 6, 21000.00),
(7, 'Tanvi Desai', 'Saleswoman', 7, 27000.00),
(8, 'Rahul Jain', 'Salesman', 8, 23000.00),
(9, 'Divya Shah', 'Manager', 9, 36000.00),
(10, 'Karan Nair', 'Sales Executive', 10, 25000.00);

-- to display all table data
SELECT * FROM Employees;

-- to remove complete records from table
TRUNCATE TABLE Employees;

-- to remove complete records and attributes from table
DROP TABLE Employees;


--  Insert a new employee (DML)
INSERT INTO Employees VALUES (11, 'Mansi Kale', 'HR', 2, 26000.00);

--  Update salary of a specific employee (DML)
UPDATE Employees SET Salary = 37000 WHERE EmployeeID = 1;

-- Delete employee with low salary (DML)
DELETE FROM Employees WHERE Salary < 21000;

--  Select employees earning more than 25k (DQL + WHERE)
SELECT * FROM Employees WHERE Salary > 25000;

--  Order employees by salary descending (ORDER BY)
SELECT * FROM Employees ORDER BY Salary DESC;

-- Get top 3 highest paid employees (LIMIT clause)
SELECT * FROM Employees ORDER BY Salary DESC LIMIT 3;

-- Get total employees in each post (GROUP BY + COUNT)
SELECT Post, COUNT(*) AS Count FROM Employees GROUP BY Post;

-- Get average salary per post (GROUP BY + AVG)
SELECT Post, AVG(Salary) AS AvgSalary FROM Employees GROUP BY Post;

-- Add a new column for experience (DDL)
ALTER TABLE Employees ADD ExperienceYears INT;

--  Rename column “Post” to “Designation” (DDL)
ALTER TABLE Employees RENAME COLUMN Post TO Designation;

-- Rollback salary update (TCL)
START TRANSACTION;
UPDATE Employees SET Salary = 50000 WHERE EmployeeID = 2;
ROLLBACK;

-- Commit salary update (TCL)
START TRANSACTION;
UPDATE Employees SET Salary = 26000 WHERE EmployeeID = 2;
COMMIT;

-- Grant SELECT on Employees (DCL)
GRANT SELECT ON Employees TO 'readonly_user'@'localhost';

--  Revoke DELETE permission (DCL)
REVOKE DELETE ON Employees FROM 'readonly_user'@'localhost';

-- Use of ALIAS in SELECT
SELECT Name AS EmployeeName, Salary AS MonthlySalary FROM Employees;

-- LIKE operator to find Salesman-related posts
SELECT * FROM Employees WHERE Designation LIKE '%Sales%';

-- IN operator for multiple post types
SELECT * FROM Employees WHERE Designation IN ('Manager', 'Technician');

--  BETWEEN operator for salary range
SELECT * FROM Employees WHERE Salary BETWEEN 22000 AND 30000;

-- LENGTH function to measure name lengths
SELECT Name, LENGTH(Name) AS NameLength FROM Employees;

--  UPPER function to capitalize names
SELECT UPPER(Name) AS CapitalizedName FROM Employees;

-- CONCAT to create employee introduction
SELECT CONCAT(Name, ' - ', Designation) AS Introduction FROM Employees;

-- COALESCE with new column ExperienceYears
SELECT Name, COALESCE(ExperienceYears, 0) AS Experience FROM Employees;

-- MOD operator to find even salary
SELECT Name, Salary FROM Employees WHERE MOD(Salary, 2) = 0;

-- Subquery to find employees with max salary
SELECT * FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);

-- EXISTS subquery to verify if ShopID 2 has employees
SELECT * FROM Employees WHERE EXISTS (
  SELECT 1 FROM Employees WHERE ShopID = 2
);

-- Create view of high-salary employees
CREATE VIEW HighSalaryEmployees AS
SELECT * FROM Employees WHERE Salary > 30000;

-- Select from view
SELECT * FROM HighSalaryEmployees;

--  INNER JOIN with Shops table
SELECT e.Name, e.Designation, s.ShopName
FROM Employees e
JOIN Shops s ON e.ShopID = s.ShopID;

-- LEFT JOIN for employees with shops
SELECT e.Name, s.ShopName
FROM Employees e
LEFT JOIN Shops s ON e.ShopID = s.ShopID;

-- JOIN with aggregation (number of employees per shop)
SELECT s.ShopName, COUNT(e.EmployeeID) AS TotalEmployees
FROM Shops s
LEFT JOIN Employees e ON s.ShopID = e.ShopID
GROUP BY s.ShopName;

-- Use function in SELECT
SELECT Name, GetSalaryGrade(Salary) AS Grade FROM Employees;

-- Stored procedure to update designation
DELIMITER $$
CREATE PROCEDURE UpdateDesignation(IN empID INT, IN newPost VARCHAR(50))
BEGIN
  UPDATE Employees SET Designation = newPost WHERE EmployeeID = empID;
END $$
DELIMITER ;

--  Call the procedure
CALL UpdateDesignation(2, 'Senior Salesman');

-- Stored procedure to return all managers
DELIMITER $$
CREATE PROCEDURE GetAllManagers()
BEGIN
  SELECT * FROM Employees WHERE Designation = 'Manager';
END $$
DELIMITER ;

-- Call manager procedure
CALL GetAllManagers();

--  Find shops that have more than 1 employee
SELECT ShopID, COUNT(*) AS EmpCount
FROM Employees
GROUP BY ShopID
HAVING COUNT(*) > 1;

-- Display top 3 posts with highest average salary
SELECT Designation, AVG(Salary) AS AvgPay
FROM Employees
GROUP BY Designation
ORDER BY AvgPay DESC
LIMIT 3;

-- Find employees whose names contain first and last name
SELECT * FROM Employees WHERE Name LIKE '% %';

-- Create view of only sales-related employees
CREATE VIEW SalesEmployees AS
SELECT * FROM Employees WHERE Designation LIKE '%Sales%';

--  Drop the view
DROP VIEW IF EXISTS SalesEmployees;

--  Backup table
CREATE TABLE Employees_Backup AS SELECT * FROM Employees;

-- Find total payroll per shop (JOIN + SUM)
SELECT s.ShopName, SUM(e.Salary) AS Payroll
FROM Shops s
JOIN Employees e ON s.ShopID = e.ShopID
GROUP BY s.ShopName;

--  Mask salary (replace with range)
SELECT Name,
  CASE
    WHEN Salary > 35000 THEN '35K+'
    WHEN Salary >= 25000 THEN '25K-35K'
    ELSE '<25K'
  END AS SalaryRange
FROM Employees;

-- Employees whose salary is above average
SELECT * FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Delete employees with NULL experience
DELETE FROM Employees WHERE ExperienceYears IS NULL;

-- Rename table for audit
RENAME TABLE Employees TO MallEmployees;



-- Table 3: Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(8,2),
    ShopID INT
);

INSERT INTO Products(ProductID, ProductName, Category, Price, ShopID) VALUES
(1, 'T-Shirt', 'Clothing', 999.99, 1),
(2, 'Running Shoes', 'Footwear', 3499.00, 2),
(3, 'Jeans', 'Clothing', 1499.50, 3),
(4, 'Smartphone', 'Electronics', 25999.00, 4),
(5, 'Wallet', 'Accessories', 799.00, 5),
(6, 'Kurta', 'Ethnic Wear', 1199.00, 6),
(7, 'iPhone', 'Electronics', 74999.00, 7),
(8, 'Denim Jacket', 'Denim', 1999.00, 8),
(9, 'LED TV', 'Electronics', 39999.00, 9),
(10, 'Gift Card', 'Gifts', 500.00, 10);

-- to display all table data
SELECT * FROM Products;

-- to remove complete records from table
TRUNCATE TABLE Products;

-- to remove complete records and attributes from table
DROP TABLE Products;

-- Insert a new product record (DML)
INSERT INTO Products VALUES (11, 'Bluetooth Headset', 'Electronics', 2999.00, 4);

-- Update the price of a specific product (DML)
UPDATE Products SET Price = 2599.00 WHERE ProductID = 11;

-- Delete a product that is discontinued (DML)
DELETE FROM Products WHERE ProductName = 'Gift Card';

-- Select all products in Electronics category (DQL + WHERE clause)
SELECT * FROM Products WHERE Category = 'Electronics';

-- Display products ordered by price descending (ORDER BY clause)
SELECT * FROM Products ORDER BY Price DESC;

-- Get the top 5 most expensive products (LIMIT clause)
SELECT * FROM Products ORDER BY Price DESC LIMIT 5;

-- Get distinct product categories (DISTINCT)
SELECT DISTINCT Category FROM Products;

-- Count total products in each category (GROUP BY + COUNT)
SELECT Category, COUNT(*) AS ProductCount FROM Products GROUP BY Category;

-- Calculate average price per category (GROUP BY + AVG)
SELECT Category, AVG(Price) AS AvgPrice FROM Products GROUP BY Category;

-- Add a new column to track stock quantity (DDL)
ALTER TABLE Products ADD QuantityInStock INT;

-- Modify column to allow larger price values (DDL)
ALTER TABLE Products MODIFY Price DECIMAL(10,2);

-- Rename column ProductName to ItemName (DDL)
ALTER TABLE Products RENAME COLUMN ProductName TO ItemName;

-- Start a transaction for price update and rollback (TCL)
START TRANSACTION;
UPDATE Products SET Price = 0 WHERE ProductID = 4;
ROLLBACK;

-- Start a transaction and commit changes (TCL)
START TRANSACTION;
UPDATE Products SET Price = 26999.00 WHERE ProductID = 4;
COMMIT;

-- Grant SELECT permission to a readonly user (DCL)
GRANT SELECT ON Products TO 'readonly_user'@'localhost';

-- Revoke DELETE permission from readonly user (DCL)
REVOKE DELETE ON Products FROM 'readonly_user'@'localhost';

-- Select with alias for readability
SELECT ItemName AS Product, Category AS Type, Price AS Cost FROM Products;

-- Use of LIKE to find all clothing-related items
SELECT * FROM Products WHERE Category LIKE '%Clothing%';

-- Use of IN to select specific categories
SELECT * FROM Products WHERE Category IN ('Electronics', 'Footwear');

-- Use of BETWEEN to find mid-range priced items
SELECT * FROM Products WHERE Price BETWEEN 1000 AND 5000;

-- Use LENGTH function to find long item names
SELECT ItemName, LENGTH(ItemName) AS NameLength FROM Products;

-- Use of UPPER to convert names to uppercase
SELECT UPPER(ItemName) AS ProductUpper FROM Products;

-- Concatenate item name with price
SELECT CONCAT(ItemName, ' - ₹', Price) AS Label FROM Products;

-- Use of CASE for discount tier classification
SELECT ItemName, Price,
  CASE
    WHEN Price >= 30000 THEN 'Premium'
    WHEN Price BETWEEN 5000 AND 29999 THEN 'Standard'
    ELSE 'Budget'
  END AS PriceTier
FROM Products;

-- COALESCE to handle null stock quantities
SELECT ItemName, COALESCE(QuantityInStock, 0) AS AvailableUnits FROM Products;

-- MOD function to find products with even price values
SELECT * FROM Products WHERE MOD(FLOOR(Price), 2) = 0;

-- Subquery to find products priced above average
SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- Subquery using EXISTS to ensure at least one product in Denim
SELECT * FROM Products WHERE EXISTS (
  SELECT 1 FROM Products WHERE Category = 'Denim'
);

-- Create a view for high-priced products
CREATE VIEW ExpensiveProducts AS
SELECT * FROM Products WHERE Price > 25000;

-- Select from the view
SELECT * FROM ExpensiveProducts;

-- CTE to rank products by price
WITH PriceRanking AS (
  SELECT ItemName, Category, Price,
         RANK() OVER (ORDER BY Price DESC) AS PriceRank
  FROM Products
)
SELECT * FROM PriceRanking;

-- CTE to get average price per shop
WITH ShopAverage AS (
  SELECT ShopID, AVG(Price) AS AvgShopPrice
  FROM Products
  GROUP BY ShopID
)
SELECT * FROM ShopAverage;

-- INNER JOIN with Shops to show shop name with product
SELECT p.ItemName, p.Category, s.ShopName
FROM Products p
JOIN Shops s ON p.ShopID = s.ShopID;

-- LEFT JOIN to get all products even if the shop is not matched
SELECT p.ItemName, s.ShopName
FROM Products p
LEFT JOIN Shops s ON p.ShopID = s.ShopID;

-- Aggregated JOIN: total value of inventory per shop
SELECT s.ShopName, SUM(p.Price) AS TotalInventoryValue
FROM Shops s
JOIN Products p ON s.ShopID = p.ShopID
GROUP BY s.ShopName;

-- User-defined function to classify product cost level
DELIMITER $$
CREATE FUNCTION GetPriceLevel(p DECIMAL(10,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
  RETURN CASE
    WHEN p > 30000 THEN 'High'
    WHEN p >= 1000 THEN 'Medium'
    ELSE 'Low'
  END;
END $$
DELIMITER ;

-- Use the UDF in a query
SELECT ItemName, Price, GetPriceLevel(Price) AS CostLevel FROM Products;

-- Stored procedure to update product price
DELIMITER $$
CREATE PROCEDURE UpdateProductPrice(IN pid INT, IN newPrice DECIMAL(10,2))
BEGIN
  UPDATE Products SET Price = newPrice WHERE ProductID = pid;
END $$
DELIMITER ;

-- Call the stored procedure
CALL UpdateProductPrice(3, 1599.00);

-- Stored procedure to list products by category
DELIMITER $$
CREATE PROCEDURE GetProductsByCategory(IN cat VARCHAR(50))
BEGIN
  SELECT * FROM Products WHERE Category = cat;
END $$
DELIMITER ;

-- Call the category procedure
CALL GetProductsByCategory('Electronics');

-- Create a view for affordable products
CREATE VIEW BudgetProducts AS
SELECT * FROM Products WHERE Price < 2000;

-- Drop the view
DROP VIEW IF EXISTS BudgetProducts;

-- Mask product prices for user-facing reports
SELECT ItemName,
  CASE
    WHEN Price > 30000 THEN '30K+'
    WHEN Price > 10000 THEN '10K - 30K'
    ELSE '<10K'
  END AS PriceBracket
FROM Products;

-- Show products whose name includes "Jeans" or "Jacket"
SELECT * FROM Products WHERE ItemName LIKE '%Jeans%' OR ItemName LIKE '%Jacket%';

-- Backup Products table
CREATE TABLE Products_Backup AS SELECT * FROM Products;

-- Restore Products from backup
INSERT INTO Products SELECT * FROM Products_Backup;

-- Delete products that are out of stock (assuming QuantityInStock)
DELETE FROM Products WHERE QuantityInStock = 0;

-- Find shops with most expensive products
SELECT s.ShopName, MAX(p.Price) AS MaxPrice
FROM Shops s
JOIN Products p ON s.ShopID = p.ShopID
GROUP BY s.ShopName;

-- Count products per category with HAVING clause
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category
HAVING COUNT(*) > 1;



-- Table 4: Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

INSERT INTO Customers(CustomerID, Name, Gender, Phone, Email) VALUES
(1, 'Aarav Mehta', 'Male', '9876543201', 'aarav@gmail.com'),
(2, 'Simran Kaur', 'Female', '9876543202', 'simran@gmail.com'),
(3, 'Rohan Das', 'Male', '9876543203', 'rohan@gmail.com'),
(4, 'Meena Iyer', 'Female', '9876543204', 'meena@gmail.com'),
(5, 'Yash Saxena', 'Male', '9876543205', 'yash@gmail.com'),
(6, 'Priya Nair', 'Female', '9876543206', 'priya@gmail.com'),
(7, 'Kunal Verma', 'Male', '9876543207', 'kunal@gmail.com'),
(8, 'Anjali Rathi', 'Female', '9876543208', 'anjali@gmail.com'),
(9, 'Dev Sharma', 'Male', '9876543209', 'dev@gmail.com'),
(10, 'Neeta Singh', 'Female', '9876543210', 'neeta@gmail.com');

-- to diplay all table data
SELECT * FROM Customers;

-- to remove complete records from table
TRUNCATE TABLE Customers;

-- to remove complete records and attributes from table
DROP TABLE Customers;

-- Create the Customers table (DDL)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

-- Insert a new customer (DML)
INSERT INTO Customers VALUES (11, 'Ritika Kapoor', 'Female', '9876543211', 'ritika@gmail.com');

-- Update a customer email (DML)
UPDATE Customers SET Email = 'updated_aarav@gmail.com' WHERE CustomerID = 1;

-- Delete a customer who opted out (DML)
DELETE FROM Customers WHERE CustomerID = 11;

-- Select all female customers (DQL + WHERE)
SELECT * FROM Customers WHERE Gender = 'Female';

-- Select customers ordered by name (ORDER BY clause)
SELECT * FROM Customers ORDER BY Name ASC;

-- Select first 5 customers (LIMIT clause)
SELECT * FROM Customers LIMIT 5;

-- Get distinct genders (DISTINCT)
SELECT DISTINCT Gender FROM Customers;

-- Count number of male and female customers (GROUP BY + COUNT)
SELECT Gender, COUNT(*) AS Total FROM Customers GROUP BY Gender;

-- Find average length of customer names (AGGREGATE + LENGTH)
SELECT AVG(LENGTH(Name)) AS AvgNameLength FROM Customers;

-- Add a new column for City (DDL)
ALTER TABLE Customers ADD City VARCHAR(50);

-- Change datatype of Phone column (DDL)
ALTER TABLE Customers MODIFY Phone VARCHAR(20);

-- Rename column Name to FullName (DDL)
ALTER TABLE Customers RENAME COLUMN Name TO FullName;

-- Start a transaction, update, then rollback (TCL)
START TRANSACTION;
UPDATE Customers SET Email = 'testrollback@gmail.com' WHERE CustomerID = 2;
ROLLBACK;

-- Commit a valid update (TCL)
START TRANSACTION;
UPDATE Customers SET Email = 'finalupdate@gmail.com' WHERE CustomerID = 2;
COMMIT;

-- Grant SELECT permission (DCL)
GRANT SELECT ON Customers TO 'readonly_user'@'localhost';

-- Revoke DELETE permission (DCL)
REVOKE DELETE ON Customers FROM 'readonly_user'@'localhost';

-- Select with aliases
SELECT FullName AS Customer, Email AS ContactEmail FROM Customers;

-- Use LIKE to find names starting with 'A'
SELECT * FROM Customers WHERE FullName LIKE 'A%';

-- IN operator for filtering specific names
SELECT * FROM Customers WHERE FullName IN ('Aarav Mehta', 'Simran Kaur');

-- Use BETWEEN for ID range
SELECT * FROM Customers WHERE CustomerID BETWEEN 3 AND 7;

-- Use LENGTH to find customers with long names
SELECT FullName, LENGTH(FullName) AS NameLength FROM Customers;

-- UPPER function for uppercase names
SELECT UPPER(FullName) AS UpperName FROM Customers;

-- CONCAT full name with email
SELECT CONCAT(FullName, ' - ', Email) AS Identity FROM Customers;

-- CASE to categorize by gender
SELECT FullName, 
  CASE
    WHEN Gender = 'Male' THEN 'M'
    ELSE 'F'
  END AS GenderShort
FROM Customers;

-- COALESCE to display default city if NULL
SELECT FullName, COALESCE(City, 'Unknown') AS CustomerCity FROM Customers;

-- Use MOD on CustomerID to find even-numbered IDs
SELECT * FROM Customers WHERE MOD(CustomerID, 2) = 0;

-- Subquery to find customers with email domains other than Gmail
SELECT * FROM Customers
WHERE Email NOT LIKE '%gmail.com' 
AND Email IN (SELECT Email FROM Customers);

-- EXISTS to check if male customers exist
SELECT * FROM Customers
WHERE EXISTS (
  SELECT 1 FROM Customers WHERE Gender = 'Male'
);

-- Create a view of female customers
CREATE VIEW FemaleCustomers AS
SELECT * FROM Customers WHERE Gender = 'Female';

-- Select from view
SELECT * FROM FemaleCustomers;

-- Common Table Expression to rank customers by name
WITH NameRank AS (
  SELECT FullName, RANK() OVER (ORDER BY FullName ASC) AS NameOrder
  FROM Customers
)
SELECT * FROM NameRank;

-- CTE to calculate email domain frequency
WITH DomainStats AS (
  SELECT SUBSTRING_INDEX(Email, '@', -1) AS Domain, COUNT(*) AS Count
  FROM Customers
  GROUP BY Domain
)
SELECT * FROM DomainStats;

-- INNER JOIN with Orders table (assume it exists)
SELECT c.FullName, o.OrderAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- LEFT JOIN with Orders to find customers with or without orders
SELECT c.FullName, o.OrderAmount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- JOIN with COUNT to see number of orders per customer
SELECT c.FullName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FullName;

-- Create user-defined function to mask phone number
DELIMITER $$
CREATE FUNCTION MaskPhone(ph VARCHAR(15))
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
  RETURN CONCAT('XXXXXX', RIGHT(ph, 4));
END $$
DELIMITER ;

-- Use user-defined function
SELECT FullName, MaskPhone(Phone) AS SafePhone FROM Customers;

-- Stored procedure to update email
DELIMITER $$
CREATE PROCEDURE UpdateEmail(IN cid INT, IN newEmail VARCHAR(100))
BEGIN
  UPDATE Customers SET Email = newEmail WHERE CustomerID = cid;
END $$
DELIMITER ;

-- Call stored procedure
CALL UpdateEmail(4, 'meena_updated@gmail.com');

-- Stored procedure to fetch all male customers
DELIMITER $$
CREATE PROCEDURE GetMaleCustomers()
BEGIN
  SELECT * FROM Customers WHERE Gender = 'Male';
END $$
DELIMITER ;

-- Call the procedure
CALL GetMaleCustomers();

-- Create a view of customers with Gmail accounts
CREATE VIEW GmailUsers AS
SELECT * FROM Customers WHERE Email LIKE '%gmail.com';

-- Drop GmailUsers view
DROP VIEW IF EXISTS GmailUsers;

-- Classify customers by name length
SELECT FullName,
  CASE
    WHEN LENGTH(FullName) > 12 THEN 'Long Name'
    ELSE 'Short Name'
  END AS NameType
FROM Customers;

-- Show customers who haven't filled city field
SELECT * FROM Customers WHERE City IS NULL;

-- Backup the Customers table
CREATE TABLE Customers_Backup AS SELECT * FROM Customers;

-- Restore from backup
INSERT INTO Customers SELECT * FROM Customers_Backup;

-- Delete customers with fake/placeholder emails
DELETE FROM Customers WHERE Email LIKE '%test%' OR Email LIKE '%fake%';

-- Display domain from email addresses
SELECT FullName, SUBSTRING_INDEX(Email, '@', -1) AS EmailDomain FROM Customers;

-- Find duplicate phone numbers (none in this sample, but real logic)
SELECT Phone, COUNT(*) FROM Customers GROUP BY Phone HAVING COUNT(*) > 1;

-- Count how many customers have emails on each domain
SELECT SUBSTRING_INDEX(Email, '@', -1) AS Domain, COUNT(*) AS Total
FROM Customers
GROUP BY Domain;

-- Rename table for audit
RENAME TABLE Customers TO VivianaCustomers;



-- Table 5: Sales
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    Quantity INT,
    SaleDate DATE
);

INSERT INTO Sales(SaleID, ProductID,CustomerID, Quantity, SaleDate) VALUES
(1, 1, 1, 2, '2025-07-01'),
(2, 2, 2, 1, '2025-07-02'),
(3, 3, 3, 1, '2025-07-03'),
(4, 4, 4, 1, '2025-07-04'),
(5, 5, 5, 3, '2025-07-05'),
(6, 6, 6, 1, '2025-07-06'),
(7, 7, 7, 1, '2025-07-07'),
(8, 8, 8, 2, '2025-07-08'),
(9, 9, 9, 1, '2025-07-09'),
(10, 10, 10, 5, '2025-07-10');

-- to diplay all table data
SELECT * FROM Sales;

-- to remove complete records from table
TRUNCATE TABLE Sales;

-- to remove complete records and attributes from table
DROP TABLE Sales;

-- Create the Sales table (DDL)
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    Quantity INT,
    SaleDate DATE
);

-- Insert a new sale (DML)
INSERT INTO Sales VALUES (11, 3, 1, 2, '2025-07-11');

-- Update the quantity of a sale (DML)
UPDATE Sales SET Quantity = 4 WHERE SaleID = 11;

-- Delete a specific sale entry (DML)
DELETE FROM Sales WHERE SaleID = 11;

-- Select all sales done on or after July 5 (DQL + WHERE)
SELECT * FROM Sales WHERE SaleDate >= '2025-07-05';

-- Show all sales ordered by date (ORDER BY)
SELECT * FROM Sales ORDER BY SaleDate;

-- Select top 3 recent sales (LIMIT)
SELECT * FROM Sales ORDER BY SaleDate DESC LIMIT 3;

-- Find unique ProductIDs sold (DISTINCT)
SELECT DISTINCT ProductID FROM Sales;

-- Count total sales per ProductID (GROUP BY + COUNT)
SELECT ProductID, COUNT(*) AS TotalSales FROM Sales GROUP BY ProductID;

-- Sum of quantities sold per Product (GROUP BY + SUM)
SELECT ProductID, SUM(Quantity) AS TotalQty FROM Sales GROUP BY ProductID;

-- Add a new column for sale amount (DDL)
ALTER TABLE Sales ADD SaleAmount DECIMAL(10,2);

-- Change datatype of Quantity (DDL)
ALTER TABLE Sales MODIFY Quantity SMALLINT;

-- Rename column SaleDate to DateOfSale (DDL)
ALTER TABLE Sales RENAME COLUMN SaleDate TO DateOfSale;

-- Rollback after changing a sale record (TCL)
START TRANSACTION;
UPDATE Sales SET Quantity = 100 WHERE SaleID = 5;
ROLLBACK;

-- Commit a quantity update transaction (TCL)
START TRANSACTION;
UPDATE Sales SET Quantity = 3 WHERE SaleID = 5;
COMMIT;

-- Grant SELECT to readonly user (DCL)
GRANT SELECT ON Sales TO 'readonly_user'@'localhost';

-- Revoke DELETE from user (DCL)
REVOKE DELETE ON Sales FROM 'readonly_user'@'localhost';

-- Select with alias for readability
SELECT SaleID AS ID, Quantity AS UnitsSold FROM Sales;

-- Use LIKE to find dates in July
SELECT * FROM Sales WHERE DateOfSale LIKE '2025-07%';

-- IN operator to find sales of products 1, 2, 3
SELECT * FROM Sales WHERE ProductID IN (1, 2, 3);

-- Use BETWEEN to filter sales between two dates
SELECT * FROM Sales WHERE DateOfSale BETWEEN '2025-07-03' AND '2025-07-08';

-- Find total characters in each sale date (LENGTH)
SELECT DateOfSale, LENGTH(DateOfSale) AS DateLength FROM Sales;

-- Use UPPER to format string column
SELECT UPPER(CAST(DateOfSale AS CHAR)) AS UpperDate FROM Sales;

-- Concatenate ProductID and CustomerID as a key
SELECT CONCAT(ProductID, '-', CustomerID) AS SaleKey FROM Sales;

-- Use CASE to categorize quantity levels
SELECT Quantity,
  CASE
    WHEN Quantity >= 3 THEN 'Bulk'
    WHEN Quantity = 2 THEN 'Medium'
    ELSE 'Single'
  END AS Type
FROM Sales;

-- Handle NULL values in SaleAmount (COALESCE)
SELECT SaleID, COALESCE(SaleAmount, 0) AS FinalAmount FROM Sales;

-- Use MOD to find even quantity sales
SELECT * FROM Sales WHERE MOD(Quantity, 2) = 0;

-- Subquery to show sales with above-average quantity
SELECT * FROM Sales
WHERE Quantity > (SELECT AVG(Quantity) FROM Sales);

-- Subquery with EXISTS to check if Product 4 was sold
SELECT * FROM Sales
WHERE EXISTS (SELECT 1 FROM Sales WHERE ProductID = 4);

-- Create a view of sales with high quantity
CREATE VIEW HighQtySales AS
SELECT * FROM Sales WHERE Quantity >= 3;

-- Select from HighQtySales view
SELECT * FROM HighQtySales;

-- CTE to rank sales by quantity
WITH QuantityRanks AS (
  SELECT SaleID, Quantity,
         RANK() OVER (ORDER BY Quantity DESC) AS RankByQty
  FROM Sales
)
SELECT * FROM QuantityRanks;

-- CTE to count sales per product
WITH ProductSales AS (
  SELECT ProductID, COUNT(*) AS SalesCount
  FROM Sales
  GROUP BY ProductID
)
SELECT * FROM ProductSales;

-- INNER JOIN with Customers to show who bought what
SELECT s.SaleID, c.Name, s.Quantity
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

-- LEFT JOIN with Products to display product info
SELECT s.SaleID, p.ProductName, s.Quantity
FROM Sales s
LEFT JOIN Products p ON s.ProductID = p.ProductID;

-- Count how many customers bought each product
SELECT ProductID, COUNT(CustomerID) AS Buyers
FROM Sales
GROUP BY ProductID;

-- User-defined function to mark big sales
DELIMITER $$
CREATE FUNCTION IsBigSale(qty INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
  RETURN CASE
    WHEN qty >= 3 THEN 'YES'
    ELSE 'NO'
  END;
END $$
DELIMITER ;

-- Use UDF in a query
SELECT SaleID, Quantity, IsBigSale(Quantity) AS BigSale FROM Sales;

-- Stored procedure to update sale quantity
DELIMITER $$
CREATE PROCEDURE UpdateQty(IN sid INT, IN qty INT)
BEGIN
  UPDATE Sales SET Quantity = qty WHERE SaleID = sid;
END $$
DELIMITER ;

-- Call stored procedure
CALL UpdateQty(3, 5);

-- Stored procedure to list all sales on specific date
DELIMITER $$
CREATE PROCEDURE GetSalesByDate(IN d DATE)
BEGIN
  SELECT * FROM Sales WHERE DateOfSale = d;
END $$
DELIMITER ;

-- Call date-based sales report procedure
CALL GetSalesByDate('2025-07-04');

-- Create view for July sales only
CREATE VIEW JulySales AS
SELECT * FROM Sales WHERE MONTH(DateOfSale) = 7;

-- Drop JulySales view
DROP VIEW IF EXISTS JulySales;

-- Use CASE to mark weekend vs weekday sales
SELECT DateOfSale,
  CASE
    WHEN DAYOFWEEK(DateOfSale) IN (1,7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS DayType
FROM Sales;

-- Show products sold more than once
SELECT ProductID, COUNT(*) AS SaleCount
FROM Sales
GROUP BY ProductID
HAVING COUNT(*) > 1;

-- Create a backup table for sales
CREATE TABLE Sales_Backup AS SELECT * FROM Sales;

-- Restore from backup
INSERT INTO Sales SELECT * FROM Sales_Backup;

-- Delete sales before July 5
DELETE FROM Sales WHERE DateOfSale < '2025-07-05';

-- Rename the table for audit tracking
RENAME TABLE Sales TO MallSales;




