# https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50

SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.subject_name) AS attended_exams #matched in the Examinations
FROM Students AS s
CROSS JOIN Subjects AS sub #every student × every subject
LEFT JOIN Examinations AS e 
    ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name#group rows so that the COUNT() works
ORDER BY s.student_id, sub.subject_name
