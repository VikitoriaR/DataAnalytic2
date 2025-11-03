Select classroom
FROM Schedule
group BY classroom
HAVING count (*) =(
       Select max (cl_cnt)
       From (
            SELECT COUNT(*) as cl_cnt
            FROM Schedule
            Group BY classroom
            )
)