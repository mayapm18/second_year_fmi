# https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

SELECT s.user_id, ROUND(IFNULL(COUNT(CASE WHEN c.action = 'confirmed' THEN 1 END) / COUNT(c.action), 0), 2) AS confirmation_rate
#IFNULL : when NULL = 0
FROM Signups s
LEFT JOIN Confirmations c #add B to A and if B doesn’t have a match, still keep the row from A
    ON s.user_id = c.user_id
GROUP BY s.user_id;
