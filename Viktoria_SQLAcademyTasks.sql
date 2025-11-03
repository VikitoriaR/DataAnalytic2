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

--60
with tab as(select teac.id, class.name,
dense_rank() over(partition by teac.id order by class.name) as rank
from schedule sched
left join teacher teac on, sched.teacher = teac.id
left join class on sched.class = class.id
where class.name like '11%'
order by teac.id)
select id as teacher
from tab
where rank >=2
group by teacher;

--55
with tab1 as (select count(trip.company), comp.name, comp.id
from Trip
left join company comp on trip.company = comp.id
group by comp.name, comp.id),
tab2 as(
select 
min(count) from tab1),
tab3 as(
select id
from tab1
where count = 2)
delete from company
where company.id IN (select id from tab3)

--58
insert into reviews (id, reservation_id, rating)
values
((select 
count(*) + 1 from reviews),
(select Rsv.id
from Reservations Rsv
left join rooms rms ON Rsv.room_id = rms.id
left join users u ON Rsv.user_id = u.id
where rms.address = '11218, Friel Place, New York'
  and u.name = 'George Clooney'), 5)
  
  --68
 with tab as(select room_id, user_id, end_date,
max(end_date) over (partition by room_id) as rank
from Reservations),
tab2 as
(select room_id, user_id, end_date,
case when end_date = rank then 1 else 0 end as result
from tab)
select tab2.room_id, users.name, tab2.end_date
from tab2
left join users on tab2.user_id = users.id
where result = 1;

--69
select rooms.owner_id,
coalesce(sum(rsv.total), 0) as total_earn
from rooms
left join Reservations rsv on rooms.id = rsv.room_id
group by rooms.owner_id

--71
with tab as (select user_id as active_users
from Reservations 
UNION 
select owner_id as active_users
from Reservations Rsv
inner join rooms on rsv.room_id = rooms.id)
select round(
((select count(active_users) from tab)::numeric)/
((select count(*) from users)::numeric) * 100, 2) as percent
