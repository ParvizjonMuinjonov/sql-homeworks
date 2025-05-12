-- Drop table if exists
DROP TABLE IF EXISTS Employees;

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    ManagerID INTEGER NULL,
    JobTitle VARCHAR(100) NOT NULL
);

-- Employees table
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) VALUES
(1001, NULL, 'President'),
(2002, 1001, 'Director'),
(3003, 1001, 'Office Manager'),
(4004, 2002, 'Engineer'),
(5005, 2002, 'Engineer'),
(6006, 2002, 'Engineer');

-- Q1: Find Level of Depth from President
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, ManagerID, JobTitle, 0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.ManagerID, e.JobTitle, eh.Depth + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT EmployeeID, ManagerID, JobTitle, Depth
FROM EmployeeHierarchy
ORDER BY EmployeeID;

-- Q2: Find Factorials up to N=10
WITH RECURSIVE Factorial AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM Factorial
    WHERE Num < 10
)
SELECT Num, Factorial
FROM Factorial
ORDER BY Num;

-- Q3: Find Fibonacci Numbers up to N=10
WITH RECURSIVE Fibonacci AS (
    SELECT 1 AS n, 1 AS Fibonacci_Number, 0 AS Prev
    UNION ALL
    SELECT n + 1, CASE WHEN n = 1 THEN 1 ELSE Fibonacci_Number + Prev END, Fibonacci_Number
    FROM Fibonacci
    WHERE n < 10
)
SELECT n, Fibonacci_Number
FROM Fibonacci
ORDER BY n;