/*
Problem:
Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.
*/

/* Solution */
SELECT
    e.employee_id
    , e.name
    , COUNT(*) reports_count
    , ROUND(AVG(f.age)) average_age
FROM Employees e
JOIN Employees f
    ON e.employee_id=f.reports_to
GROUP BY e.employee_id
ORDER BY employee_id
