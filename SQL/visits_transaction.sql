# https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/?envType=study-plan-v2&envId=top-sql-50

SELECT customer_id, count_no_trans
FROM Visits
WHERE visit_id NOT IN 
SELECT visit_id
FROM Transactions
#?????