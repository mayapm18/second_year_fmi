# https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/?envType=study-plan-v2&envId=top-sql-50

SELECT customer_id, COUNT(visit_id) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN 
( 
SELECT visit_id
FROM Transactions
)
#Keep only those visits that are not found in the Transactions table.
GROUP BY customer_id

#GROUP BY collects rows that have the same value into one group
#so you can count, sum, or average them.