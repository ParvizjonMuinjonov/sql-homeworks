--CREATE TABLE Employees (
--    EmployeeID INT PRIMARY KEY,
--    Name VARCHAR(50),
--    Department VARCHAR(50),
--    Salary DECIMAL(10,2),
--    HireDate DATE
--);

--INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
--(1, 'Alice Johnson', 'HR', 4500.00, '2020-01-15'),
--(2, 'Bob Smith', 'HR', 4600.00, '2021-03-12'),
--(3, 'Carol Davis', 'HR', 4500.00, '2022-07-20'),
--(4, 'David Harris', 'HR', 4800.00, '2023-02-05'),
--(5, 'Eva Adams', 'HR', 4200.00, '2024-01-01'),

--(6, 'Frank Moore', 'IT', 7000.00, '2019-08-01'),
--(7, 'Grace Lee', 'IT', 7100.00, '2020-04-14'),
--(8, 'Henry Taylor', 'IT', 6900.00, '2021-11-11'),
--(9, 'Ivy Brown', 'IT', 7200.00, '2022-09-10'),
--(10, 'Jack Wilson', 'IT', 6800.00, '2023-06-16'),

--(11, 'Karen Lewis', 'Finance', 6000.00, '2020-03-01'),
--(12, 'Leo Walker', 'Finance', 6100.00, '2021-05-03'),
--(13, 'Mona Young', 'Finance', 5900.00, '2022-10-10'),
--(14, 'Nate Hall', 'Finance', 6200.00, '2023-01-15'),
--(15, 'Olivia Allen', 'Finance', 5800.00, '2023-12-25'),

--(16, 'Paul Scott', 'Marketing', 5100.00, '2019-09-09'),
--(17, 'Quinn Green', 'Marketing', 5200.00, '2020-06-20'),
--(18, 'Rachel Baker', 'Marketing', 5000.00, '2021-03-03'),
--(19, 'Steve King', 'Marketing', 5300.00, '2022-05-30'),
--(20, 'Tina Hill', 'Marketing', 4900.00, '2024-04-01'),

--(21, 'Uma Adams', 'Sales', 6500.00, '2019-07-10'),
--(22, 'Victor Perez', 'Sales', 6400.00, '2020-01-25'),
--(23, 'Wendy Cox', 'Sales', 6300.00, '2021-08-19'),
--(24, 'Xander Rivera', 'Sales', 6600.00, '2022-12-01'),
--(25, 'Yara Ward', 'Sales', 6700.00, '2024-03-20'),

--(26, 'Zane Ford', 'HR', 4700.00, '2022-06-06'),
--(27, 'Amy Clark', 'IT', 7250.00, '2023-08-08'),
--(28, 'Brian White', 'Finance', 6000.00, '2022-02-02'),
--(29, 'Chloe Martin', 'Marketing', 5400.00, '2021-01-01'),
--(30, 'Daniel Garcia', 'Sales', 6600.00, '2023-07-07'),

--(31, 'Elena Price', 'HR', 4550.00, '2021-11-11'),
--(32, 'Felix Ross', 'IT', 7400.00, '2024-01-10'),
--(33, 'Gina Brooks', 'Finance', 6100.00, '2021-12-12'),
--(34, 'Hank Cooper', 'Marketing', 5200.00, '2023-03-03'),
--(35, 'Iris Kelly', 'Sales', 6650.00, '2023-09-09'),

--(36, 'James Reed', 'HR', 4900.00, '2023-05-05'),
--(37, 'Kylie Barnes', 'IT', 7000.00, '2020-10-10'),
--(38, 'Liam Black', 'Finance', 6300.00, '2024-04-12'),
--(39, 'Mia Stevens', 'Marketing', 5100.00, '2020-08-08'),
--(40, 'Noah Ross', 'Sales', 6400.00, '2021-04-04'),

--(41, 'Olga Grant', 'HR', 4450.00, '2021-06-06'),
--(42, 'Peter Long', 'IT', 7150.00, '2021-09-09'),
--(43, 'Queenie Knight', 'Finance', 6200.00, '2023-08-08'),
--(44, 'Ronald Kim', 'Marketing', 5350.00, '2022-11-11'),
--(45, 'Sophie Dean', 'Sales', 6600.00, '2022-10-10'),

--(46, 'Tommy Gray', 'HR', 4350.00, '2024-02-14'),
--(47, 'Ursula Pope', 'IT', 7250.00, '2023-12-12'),
--(48, 'Vera Sharp', 'Finance', 6150.00, '2023-09-09'),
--(49, 'Willie Nash', 'Marketing', 5450.00, '2024-03-03'),
--(50, 'Xenia Moon', 'Sales', 6550.00, '2024-04-04');

-- 1) Assign a Unique Rank to Each Employee Based on Salary
SELECT Name, Department, Salary,
	DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary) AS unique_ranked_salary
FROM Employees;

-- 2) Find Employees Who Have the Same Salary Rank
WITH Ranked AS (
    SELECT Name, Department, Salary,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary) AS rank
    FROM Employees
)
SELECT Name, Department, Salary, rank
FROM Ranked
WHERE rank IN (
    SELECT rank
    FROM Ranked
    GROUP BY Department, rank
    HAVING COUNT(*) > 1
)
ORDER BY Department, rank, Name;

-- 3) Identify the Top 2 Highest Salaries in Each Department
WITH RankedSalaries AS (
    SELECT 
        Name,
        Department,
        Salary,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS salary_rank
    FROM Employees
)
SELECT 
    Name,
    Department,
    Salary,
    salary_rank
FROM RankedSalaries
WHERE salary_rank <= 2
ORDER BY Department, Salary DESC, Name;

-- 4) Find the Lowest-Paid Employee in Each Department
WITH RankedSalaries AS (
    SELECT 
        Name,
        Department,
        Salary,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary) AS salary_rank
    FROM Employees
)
SELECT 
    Name,
    Department,
    Salary,
    salary_rank
FROM RankedSalaries
WHERE salary_rank = 1
ORDER BY Department, Salary, Name;

-- 5) Calculate the Running Total of Salaries in Each Department
SELECT 
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (
        PARTITION BY Department 
    ) AS running_total_salary
FROM Employees;

-- 6) Find the Total Salary of Each Department Without GROUP BY
SELECT 
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (
        PARTITION BY Department 
    ) AS running_total_salary
FROM Employees;

-- 7) Calculate the Average Salary in Each Department Without GROUP BY
SELECT 
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        PARTITION BY Department 
    ) AS running_total_salary
FROM Employees;

-- 8) Find the Difference Between an Employee’s Salary and Their Department’s Average
SELECT 
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS dept_avg_salary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS salary_difference
FROM Employees
ORDER BY Department, Salary DESC, Name; 

-- 9) Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

-- 10) Find the Sum of Salaries for the Last 3 Hired Employees
WITH Last3Hired AS (
    SELECT Salary
    FROM Employees
    ORDER BY HireDate DESC
    LIMIT 3
)
SELECT SUM(Salary) AS SumOfLast3HiredSalaries
FROM Last3

-- 11) Calculate the Running Average of Salaries Over All Previous Employees
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY HireDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningAvgSalary
FROM Employees;

-- 12) Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After

SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    MAX(Salary) OVER (
        ORDER BY EmployeeID
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    ) AS MaxSalaryWindow_2Before_2After
FROM Employees;

-- 13) Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    ROUND(
        Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department), 2
    ) AS SalaryPercentageInDept
FROM Employees;

