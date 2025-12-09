# https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

SELECT s.user_id, ROUND(AVG(IF(c.action = 'confirmed',1,0)),2) AS confirmation_rate #confirmed = 1, others=0, then avg
FROM Signups s
RIGHT JOIN Confirmation c ON s.user_id = c.user_id #match rows from S and C -> user_id are equal
GROUP BY s.user_id