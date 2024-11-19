/*
Problem:
Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
 

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.
*/

/* Solution - original with Join */
WITH topN AS
(
SELECT
    *
    , DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary desc) nrank
FROM Employee
)

SELECT 
    d.name Department
    , e.name Employee
    , salary
FROM topN e
JOIN Department d
    ON e.departmentId=d.id
WHERE nrank<=3


/* Alternative - better performance - dense rank, join department name then filter out rank<=3
SELECT department, employee, salary
FROM
(    
    SELECT
        dept.name AS department,
        emp.name AS employee,
        emp.salary AS salary,
        DENSE_RANK() OVER(PARTITION BY dept.name ORDER BY emp.salary DESC) AS unqrk
    FROM employee emp
    JOIN department dept ON dept.id = emp.departmentid
) AS table1
WHERE unqrk < 4;
*/
