-- Drop tables if they exist
DROP TABLE IF EXISTS Groupings;
DROP TABLE IF EXISTS EMPLOYEES_N;

-- Groupings Table
CREATE TABLE Groupings (
    StepNumber INT PRIMARY KEY,
    Status VARCHAR(20)
);

-- EMPLOYEES_N Table
CREATE TABLE EMPLOYEES_N (
    EMPLOYEE_ID INT NOT NULL,
    FIRST_NAME VARCHAR(20) NULL,
    HIRE_DATE DATE NOT NULL
);

-- Groupings table
INSERT INTO Groupings (StepNumber, Status) VALUES
(1, 'Passed'),
(2, 'Passed'),
(3, 'Passed'),
(4, 'Passed'),
(5, 'Failed'),
(6, 'Failed'),
(7, 'Failed'),
(8, 'Failed'),
(9, 'Failed'),
(10, 'Passed'),
(11, 'Passed'),
(12, 'Passed');

-- EMPLOYEES_N table
INSERT INTO EMPLOYEES_N (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE) VALUES
(1, 'Alice', '1975-06-15'),
(2, 'Bob', '1976-03-22'),
(3, 'Charlie', '1977-09-10'),
(4, 'David', '1979-11-05'),
(5, 'Eve', '1980-07-19'),
(6, 'Frank', '1982-04-12'),
(7, 'Grace', '1983-08-25'),
(8, 'Henry', '1984-01-30'),
(9, 'Ivy', '1985-12-03'),
(10, 'Jack', '1990-05-14'),
(11, 'Karen', '1997-02-28');

-- Q1: Count Consecutive Values in Status Field
WITH StatusChange AS (
    SELECT 
        StepNumber,
        Status,
        SUM(CASE WHEN Status = LAG(Status) OVER (ORDER BY StepNumber) THEN 0 ELSE 1 END) 
            OVER (ORDER BY StepNumber) AS group_id
    FROM Groupings
)
SELECT 
    MIN(StepNumber) AS MinStepNumber,
    MAX(StepNumber) AS MaxStepNumber,
    Status,
    COUNT(*) AS ConsecutiveCount
FROM StatusChange
GROUP BY group_id, Status
ORDER BY MinStepNumber;

-- Q2: Find Year-Based Intervals With No Hires
WITH AllYears AS (
    SELECT 1975 + n AS Year
    FROM (
        SELECT a.N + b.N * 10 + c.N * 100 AS N
        FROM 
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
             UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
             UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
             UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
        WHERE a.N + b.N * 10 + c.N * 100 <= 50
    ) numbers
),
HiredYears AS (
    SELECT DISTINCT YEAR(HIRE_DATE) AS HireYear
    FROM EMPLOYEES_N
),
NoHireYears AS (
    SELECT Year
    FROM AllYears
    WHERE Year NOT IN (SELECT HireYear FROM HiredYears)
),
YearGroups AS (
    SELECT 
        Year,
        Year - ROW_NUMBER() OVER (ORDER BY Year) AS group_id
    FROM NoHireYears
)
SELECT 
    CAST(MIN(Year) AS VARCHAR) + ' - ' + CAST(MAX(Year) AS VARCHAR) AS Years
FROM YearGroups
GROUP BY group_id
ORDER BY MIN(Year);