# https://leetcode.com/problems/article-views-i/description/?envType=study-plan-v2&envId=top-sql-50

SELECT DISTINCT author_id as id
FROM Views
WHERE viewer_id = author_id
ORDER BY id ASC;

#DISTINCT - remove duplicate
#ASC = ascending order