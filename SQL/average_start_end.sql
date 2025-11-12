# https://leetcode.com/problems/average-time-of-process-per-machine/?envType=study-plan-v2&envId=top-sql-50
#machine_id (int)
#process_id (int)
#activity_type (enum 'start' or 'end')
#timestamp (float)


SELECT s.machine_id ,AVG(e.timestamp - s.timestamp) AS processing_time
FROM Activity s, Activity e
WHERE s.activity_type = 'start' AND e.activity_type = 'end'
AND s.machine_id = e.machine_id
AND s.process_id = e.process_id
GROUP BY machine_id

#output
    -- | machine_id | processing_time    |
    -- | ---------- | ------------------ |
    -- | 0          | 0.8939998745918274 |
    -- | 1          | 0.9949999451637268 |
    -- | 2          | 1.4560000896453857 |