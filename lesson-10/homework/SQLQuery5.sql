-- Drop table if exists
DROP TABLE IF EXISTS Shipments;

-- Shipments Table
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

-- Shipments table
INSERT INTO Shipments (N, Num) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(8, 1),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 4),
(15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 4),
(20, 4),
(21, 4),
(22, 4),
(23, 4),
(24, 4),
(25, 4),
(26, 5),
(27, 5),
(28, 5),
(29, 5),
(30, 5),
(31, 5),
(32, 6),
(33, 7);

-- Q1: Find Median Number of Tractors Shipped Per Day
WITH AllDays AS (
    SELECT n, COALESCE(s.Num, 0) AS Num
    FROM (
        SELECT a.N + b.N * 10 + 1 AS n
        FROM 
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
             UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) b
        WHERE a.N + b.N * 10 + 1 <= 40
    ) numbers
    LEFT JOIN Shipments s ON numbers.n = s.N
),
OrderedDays AS (
    SELECT Num,
           ROW_NUMBER() OVER (ORDER BY Num) AS row_num
    FROM AllDays
)
SELECT AVG(1.0 * Num) AS Median
FROM OrderedDays
WHERE row_num IN (20, 21);