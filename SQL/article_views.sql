# https://leetcode.com/problems/article-views-i/description/?envType=study-plan-v2&envId=top-sql-50

SELECT author_id
FROM Views
RENAME COLUMN author_id TO id;
WHERE viewer_id = id

