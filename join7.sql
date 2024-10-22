/*
Problem:
Table: Students

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
 

Table: Subjects

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
 

Table: Examinations

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
 

Write a solution to find the number of times each student attended each exam.
*/

/* Solution */
WITH cte AS( 
    SELECT *
    FROM Students st
    CROSS JOIN Subjects su
    )

SELECT cte.student_id
    , cte.student_name
    , cte.subject_name
    , COUNT(e.student_id) attended_exams
FROM cte
LEFT JOIN Examinations e
    ON cte.student_id = e.student_id AND cte.subject_name=e.subject_name
GROUP BY 1,3
ORDER BY 1,3
