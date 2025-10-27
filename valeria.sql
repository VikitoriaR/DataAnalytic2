SELECT Pas.name
FROM Passenger AS Pas
INNER JOIN Pass_in_trip AS PIT
ON Pas.id = Pit.Passenger
INNER JOIN Trip 
ON pit.trip = Trip.id
WHERE trip.town_to = 'Moscow' AND trip.plane = 'TU-134'
GROUP BY Pas.name


HW2
SELECT AVG(ROUND(age, 2)) AS average_age
FROM (
		SELECT cust.customer_key, cust.age
		FROM Customer AS cust
			JOIN Purchase AS pur ON cust.customer_key = pur.customer_key
			JOIN Product AS pr ON pur.product_key = pr.product_key
		WHERE pr.name = 'Smartwatch'
		    AND EXTRACT(year from pur.date) = '2024'
		GROUP BY cust.customer_key, cust.age
	) AS unique_customers;


HW trees

-- Создадим таблицу категорий с родительской связью
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id INT REFERENCES categories(id)
);

-- Добавим данные (пример древовидной структуры)
INSERT INTO categories (name, parent_id) VALUES
('Электроника', NULL),
('Компьютеры', 1),
('Смартфоны', 1),
('Ноутбуки', 2),
('Настольные ПК', 2),
('Аксессуары', 1),
('Чехлы', 6),
('Наушники', 6),
('Игровые', 4),
('Бюджетные', 4);

-- Посмотрим все категории
SELECT * FROM categories;

-- Рекурсивный запрос: все подкатегории "Электроники"
WITH RECURSIVE category_tree AS (
    -- Якорный запрос: корневая категория
    SELECT
        id,
        name,
        parent_id,
        1 AS level,
        name::TEXT AS path
    FROM categories
    WHERE name = 'Электроника'

    UNION ALL

    -- Рекурсивная часть: ищем подкатегории
    SELECT
        c.id,
        c.name,
        c.parent_id,
        ct.level + 1 AS level,
        (ct.path || ' → ' || c.name)::TEXT AS path
    FROM categories c
    JOIN category_tree ct ON c.parent_id = ct.id
)
SELECT
    id,
    name,
    parent_id,
    level,
    path
FROM category_tree
ORDER BY level, id;