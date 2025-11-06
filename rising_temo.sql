#https://leetcode.com/problems/rising-temperature/?envType=study-plan-v2&envId=top-sql-50
#w1 = today 
#w2 = yesterday 

SELECT w1.id
FROM Weather w1, Weather w2
WHERE w1.temperature > w2.temperature
AND ON DATEDIFF(w1.recordDate, w2.recordDate) = 1