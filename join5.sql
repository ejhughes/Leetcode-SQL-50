/*
Problem:

There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
*/

/* Solution */
SELECT
    a.machine_id
    , ROUND(AVG(b.timestamp - a.timestamp),3) processing_time
FROM Activity a
JOIN Activity b
    ON a.machine_id=b.machine_id AND a.process_id=b.process_id AND a.activity_type!=b.activity_type
WHERE a.activity_type='start'
GROUP BY 1


/* Note: Doesn't feel like a particularly elegant or efficient solution, but was trying not to get into ctes or sub-queries at this stage */
