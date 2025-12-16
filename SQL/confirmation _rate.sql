# https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

# https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

SELECT s.user_id, confirmation_rate
FROM Signups
RIGHT JOIN Confirmations
WHERE (
    confirmation_rate = COUNT(confirmed actions)/COUNT(all actions)
    if no actons -> confirmation_rate=0
    ROUND(confirmation_rate, 2)
)
