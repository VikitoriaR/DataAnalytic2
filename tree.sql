with recursive tree (id, parent_id, name, level) as (
	select main.id, main.parent_id,  main.name, 0 level
	from hierarchy_example main 
	where main.parent_id is null
	UNION 
	select t2.id, t2.parent_id, t2.name, tree.level + 1
	from hierarchy_example t2, tree
	WHERE t2.parent_id = tree.id
) CYCLE id SET is_cycle USING path
select *
from tree
order by level;