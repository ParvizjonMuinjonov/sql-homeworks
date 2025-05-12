DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Customers table
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Davis'),
(4, 'David Harris');

-- Products table
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Notebook', 'Stationery'),
(4, 'Pen', 'Stationery'),
(5, 'Headphones', 'Electronics');

-- Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2025-01-01'),
(2, 1, '2025-02-01'),
(3, 2, '2025-03-01'),
(4, 3, '2025-04-01');

-- OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 1000.00), -- Alice: Laptop
(2, 1, 3, 2, 5.00),    -- Alice: Notebook
(3, 2, 2, 1, 700.00),   -- Alice: Smartphone
(4, 3, 3, 5, 5.00),     -- Bob: Notebook
(5, 3, 4, 10, 2.00),    -- Bob: Pen
(6, 4, 5, 2, 100.00);   -- Charlie: Headphones

-- Q1: Retrieve All Customers With Their Orders (Include Customers Without Orders)
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Q2: Find Customers Who Have Never Placed an Order
SELECT c.CustomerID, c.CustomerName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- Q3: List All Orders With Their Products
SELECT o.OrderID, o.OrderDate, p.ProductName, od.Quantity
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

-- Q4: Find Customers With More Than One Order
SELECT c.CustomerID, c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 1;

-- Q5: Find the Most Expensive Product in Each Order
SELECT o.OrderID, p.ProductName, od.Price
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE (o.OrderID, od.Price) IN (
    SELECT od2.OrderID, MAX(od2.Price)
    FROM OrderDetails od2
    GROUP BY od2.OrderID
);

-- Q6: Find the Latest Order for Each Customer
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate = (
    SELECT MAX(o2.OrderDate)
    FROM Orders o2
    WHERE o2.CustomerID = c.CustomerID
) OR o.OrderID IS NULL;

-- Q7: Find Customers Who Ordered Only 'Electronics' Products
SELECT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(DISTINCT p.Category) = 1 AND MAX(p.Category) = 'Electronics';

-- Q8: Find Customers Who Ordered at Least One 'Stationery' Product
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Stationery';

-- Q9: Find Total Amount Spent by Each Customer
SELECT c.CustomerID, c.CustomerName, COALESCE(SUM(od.Quantity * od.Price), 0) AS TotalSpent
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;