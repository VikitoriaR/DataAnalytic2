--44
select 
max(extract (year from age(NOW(), stud.birthday))) as max_year
from Student_in_class stclass
left join student stud on stclass.student = stud.id
left join class on stclass.class = class.id
where class.name like '10%';


--45
with r1 as (select classroom, count(classroom) as total
from Schedule
group by classroom),
r2 as
(select max(total) 
from r1)
select classroom
from r1
where total = '5'