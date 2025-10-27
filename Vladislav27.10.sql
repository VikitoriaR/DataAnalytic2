BEGIN;

CREATE TABLE IF NOT EXISTS nodes (
    id         SERIAL PRIMARY KEY,
    name       TEXT NOT NULL,
    parent_id  INT REFERENCES nodes(id)
);

COMMIT;

BEGIN;

TRUNCATE TABLE nodes RESTART IDENTITY;

INSERT INTO nodes (name, parent_id) VALUES
('Root', NULL);                         -- id = 1
INSERT INTO nodes (name, parent_id) VALUES
('Item1', 1), ('Item2', 1);           -- id = 2,3
INSERT INTO nodes (name, parent_id) VALUES
('Subitem1', 2), ('Subitem2', 2), ('Subitem3', 3);

COMMIT;

WITH RECURSIVE tree_path (node_id, node_name, parent_id, level_depth) AS (
    SELECT 
        node.id,
        node.name,
        node.parent_id,
        1 AS level_depth
    FROM nodes AS node
    WHERE node.id NOT IN (
        SELECT child.parent_id
        FROM nodes AS child
        WHERE child.parent_id IS NOT NULL
    )

    UNION ALL
    SELECT 
        parent.id,
        parent.name,
        parent.parent_id,
        tree_path.level_depth + 1
    FROM nodes AS parent
    JOIN tree_path ON parent.id = tree_path.parent_id
)
SELECT *
FROM tree_path
ORDER BY level_depth DESC, node_id;

ALTER TABLE nodes
DROP CONSTRAINT nodes_parent_id_fkey,
ADD CONSTRAINT nodes_parent_id_fkey
FOREIGN KEY (parent_id) REFERENCES nodes(id)
DEFERRABLE INITIALLY DEFERRED;