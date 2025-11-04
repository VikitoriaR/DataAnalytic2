--44
select
max(extract (year from age(NOW(), stud.birthday))) as max_year
from Student_in_class stclass
left join student stud on stclass.student = stud.id
left join class on stclass.class = class.id
where class.name IN ('10 A', '10 B');

--45
with r1 as (select classroom, count(classroom) as total
            from Schedule
            group by classroom)
select classroom
from r1
where total = (select max(total) from r1);

--60
with tab as(select teac.id, class.name,
            dense_rank() over(partition by teac.id order by class.name) as rank
            from schedule sched
            left join teacher teac on sched.teacher = teac.id
            left join class on sched.class = class.id
            where class.name IN ('11 A', '11 B')
            order by teac.id)
select id as teacher
from tab
where rank > 1
group by teacher;

 --55
with count_trip as(
             select comp.id as company_id,
             count(trip.company) as trip_count
             from trip
             left join company comp on trip.company = comp.id
             group by comp.id),
min_trips as(select company_id
             from count_trip
             where trip_count = (select min(trip_count) from count_trip))
delete from company using min_trips
where company.id = min_trips.company_id;


--58
insert into reviews (id, reservation_id, rating)
values
  ((select count(*) + 1 from reviews),
  (select Rsv.id
  from Reservations Rsv
  left join rooms rms ON Rsv.room_id = rms.id
  left join users u ON Rsv.user_id = u.id
  where rms.address = '11218, Friel Place, New York'
  and u.name = 'George Clooney'), 5);

--68
select
    rsv.room_id,
    usrs.name,
    rsv.end_date
from (
    select
    room_id,
    user_id,
    end_date,
    max(end_date) over (partition by room_id) as max_end_date
    from reservations
) rsv
left join users usrs on rsv.user_id = usrs.id
where rsv.end_date = rsv.max_end_date;


--69
select rooms.owner_id,
coalesce(sum(rsv.total), 0) as total_earn
from rooms
left join Reservations rsv on rooms.id = rsv.room_id
group by rooms.owner_id;
  
--71

with tab as (select user_id as active_users
             from Reservations
             UNION
             select owner_id as active_users
             from Reservations Rsv
             inner join rooms on rsv.room_id = rooms.id)
select round(
((select count(active_users) from tab)::numeric)/
((select count(*) from users)::numeric) * 100, 2) as percent;
