create table Geographic_hierarchy
(ID bigint generated always as identity primary key,
name varchar not null,
type varchar not null,
parent_id bigint)

insert into Geographic_hierarchy 
(name, type, parent_id)
values
('Estonia', 'Country', NULL),
('Harjumaa', 'Region', 1),
('Tartumaa', 'Region', 1),
('Ida-Virumaa', 'Region', 1),
('Tallinn', 'City', 2),
('Maardu', 'City', 2),
('Tartu', 'City', 3),
('Narva', 'City', 4),
('Lasnamae', 'District', 5),
('Kesklinn', 'District', 5),
('Mustamae', 'District', 5),
('Narva-Joesu', 'City', 4),
('Lai tn', 'Street', 10),
('Riia tn', 'Street', 7),
('Supeluse tn', 'Street', 7),
('Tammsaare tee', 'Street', 11),
('Oja tn', 'Street', 6),
('Pushkina tn', 'Street', 8),
('Ranna tn', 'Street', 12),
('Laitse', 'Area', 2)

select *
from Geographic_hierarchy geo


-- eto snizu vverh toljko gde estj rajon, area i daljshe ih roditeli

with recursive tree (id, name, type, parent_id, path) as 
  (select geo1.id, geo1.name, geo1.type, geo1.parent_id, cast(geo1.name as varchar) as path
  from Geographic_hierarchy geo1
  where geo1.type = 'Street' or geo1.type = 'Area'
  union
  select geo2.id, geo2.name, geo2.type, geo2.parent_id, cast(tree.path || '->' || geo2.name as varchar)
  from Geographic_hierarchy geo2
  inner join tree on tree.parent_id = geo2.id)

select * from tree


-- eto sverhu vniz, ot strani k gorodam - poselkam, rajonam, ulicam + dobavlen level

with recursive tree_reverse (id, name, type, parent_id, path, level) as 
  (select geo3.id, geo3.name, geo3.type, geo3.parent_id, cast(geo3.name as varchar) as path, 0 as level 
  from Geographic_hierarchy geo3
  where geo3.parent_id is null 
  union 
  select geo4.id, geo4.name, geo4.type, geo4.parent_id, cast(tree_reverse.path || '->' || geo4.name as varchar), tree_reverse.level + 1
  from Geographic_hierarchy geo4
  inner join tree_reverse on geo4.parent_id = tree_reverse.id)

select * from tree_reverse


-- eto zapros kak najti ulici, derevni bez potomkov

select geo.id, geo.name, geo.type, geo.parent_id, selfjoin.*
 from Geographic_hierarchy geo
 left join Geographic_hierarchy selfjoin on geo.id = selfjoin.parent_id
 where selfjoin.parent_id is null
 
 
-- eto zapros snizu vverh nachinaja s teh, u kogo net potomkov
 
with recursive tree_reverse2 (id, name, type, parent_id, path) as
  (select geo.id, geo.name, geo.type, geo.parent_id, cast(geo.name as varchar) as path
   from Geographic_hierarchy geo
   left join Geographic_hierarchy selfjoin on geo.id = selfjoin.parent_id
   where selfjoin.parent_id is null -- etot zhe zapros,chto vishe
   union
   select parent.id, parent.name, parent.type, parent.parent_id, cast(tree_reverse2.path || '->' || parent.name as varchar) as path
   from Geographic_hierarchy parent
   inner join tree_reverse2 on tree_reverse2.parent_id = parent.id)
   
 select *
 from tree_reverse2
 