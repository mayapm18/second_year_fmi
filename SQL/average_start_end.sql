# https://leetcode.com/problems/average-time-of-process-per-machine/?envType=study-plan-v2&envId=top-sql-50
#machine_id (int)
#process_id (int)
#activity_type (enum 'start' or 'end')
#timestamp (float)

# AVG(..., n) - pokazva 3 znaka sled zapetaqta 
SELECT machine_id, (AVG(e.timestamp - s.timestamp), 3) AS processing_time
FROM Activity s, Activity e
WHERE s.activity_type = 'start' AND e.activity_type = 'end'
AND s.machine_id = e.machine_id
AND s.process_id = e.process_id

