create table foodmarket
(id int8 primary key,
name varchar not null,
parent_id int8);

insert into foodmarket
(id, name, parent_id)
values 
(1, 'fruits_vegatables', null),
(2, 'aples', 1),
(3, 'pears', 1),
(4, 'tropical',1),
(5, 'citrus', 1),
(6, 'grapes', 1),
(7, 'golden', 2),
(8, 'gala', 2),
(9, 'champion', 2),
(10, 'conference', 3),
(11, 'coconut',4),
(12, 'mango', 4),
(13, 'passion_fruit', 4),
(14, 'papaya', 4),
(15, 'oranges', 5),
(16, 'tangerines', 5),
(17, 'yellow', 8),
(18, 'red', 8);

select *
from foodmarket food



with recursive tree (id, name, parent_id, level) as 
(
select food1.id, food1.name, food1.parent_id, 0 level
from foodmarket food1
where food1.parent_id is null
union 
select food2.id, food2.name, food2.parent_id, tree.level+1
from foodmarket food2, tree 
where food2.parent_id=tree.id
)
cycle name set is_cycle using path
 select *
 from tree
 order by level
 
 select child.id, child.name, child.parent_id
 from foodmarket child
      left join foodmarket selffood on selffood.parent_id=child.id
 where selffood.parent_id is null
 
 with recursive reverse_tree (id, name, parent_id) as 
 (
 select child.id, child.name, child.parent_id
 from foodmarket child
      left join foodmarket selffood on selffood.parent_id=child.id
 where selffood.parent_id is null
 union 
 select food3.id, food3.name, food3.parent_id
 from foodmarket food3
      inner join reverse_tree on food3.id=reverse_tree.parent_id
 )cycle name set is_cycle using path
 select *
 from reverse_tree;