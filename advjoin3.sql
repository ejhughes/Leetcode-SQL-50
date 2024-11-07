/*
Problem
Table: Triangle

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
 

Report for every three line segments whether they can form a triangle.
*/

/* Solution */
SELECT 
    *
    , CASE 
        WHEN GREATEST(x, y, z)-LEAST(x, y, z) < x+y+z - GREATEST(x, y, z) - LEAST(x, y, z)
        THEN 'Yes' ELSE 'No' END triangle
FROM Triangle

/* Alternative
SELECT *, IF(x+y>z and y+z>x and z+x>y, "Yes", "No") as triangle FROM Triangle
*/
