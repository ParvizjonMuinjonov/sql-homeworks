CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


WITH TopEmployees AS (
    SELECT TOP 10 PERCENT  *
    FROM Employees
    ORDER BY Salary DESC
)
SELECT 
    Department,
    AVG(Salary) AS AverageSalary,
    CASE 
        WHEN AVG(Salary) > 80000 THEN 'High'
        WHEN AVG(Salary) BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM TopEmployees
GROUP BY Department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;


