select 
max(extract (year from age(NOW(), stud.birthday))) as max_year
from Student_in_class stclass
left join student stud on stclass.student = stud.id
left join class on stclass.class = class.id
where class.name like '10%';