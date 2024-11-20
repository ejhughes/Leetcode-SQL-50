/*
Problem:
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null 
*/

/* Solution - over-engineered but works */
SELECT 
    MAX(CASE WHEN rankSalary=2 THEN salary ELSE NULL END) SecondHighestSalary
FROM
(
    SELECT
        DISTINCT salary
        , DENSE_RANK() OVER(ORDER BY salary desc) rankSalary
    FROM Employee
) t1

/* Alternative 1 - using Limit and Offset
select
(select distinct Salary 
from Employee order by salary desc 
limit 1 offset 1) 
as SecondHighestSalary;
*/

/* Alternative 2 - taking the Max value left over after filtering out the actual Max, resulting in the Second Highest Salary
SELECT  MAX(SALARY) AS SecondHighestSalary 
FROM EMPLOYEE 
WHERE SALARY <>(SELECT MAX(SALARY) FROM EMPLOYEE);
*/
