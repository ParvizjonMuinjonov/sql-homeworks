CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


WITH MaxPriceProducts AS (
    SELECT 
        Category,
        MAX(Price) AS MaxPrice
    FROM Products
    GROUP BY Category
)
SELECT DISTINCT 
    p.Category,
    p.ProductName,
    p.Price,
    IIF(p.Stock = 0, 'Out of Stock', 
        IIF(p.Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products p
INNER JOIN MaxPriceProducts m
    ON p.Category = m.Category AND p.Price = m.MaxPrice
ORDER BY p.Price DESC
OFFSET 5 ROWS FETCH NEXT 10 ROWS ONLY;