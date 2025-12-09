# https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

SELECT user_id, confirmation_rate
FROM Signup
RIGHT JOIN Confirmation
WHERE (
    confirmation_rate = COUNT(confirmed actions)/COUNT(all actions)
    if no actons -> confirmation_rate=0
)
