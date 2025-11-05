--Task 44
SELECT MAX(
		EXTRACT(
			YEAR
			FROM AGE(NOW(), stud.birthday)
		)
	) AS max_year
FROM Student AS stud
	JOIN Student_in_class AS sic ON stud.id = sic.student
	JOIN Class ON Class.id = sic.class
WHERE Class.name LIKE '10%';


--Task45
SELECT sch.classroom
FROM Schedule AS sch
GROUP BY classroom
HAVING COUNT(*) = (
		SELECT MAX(class_count)
		FROM (
				SELECT COUNT(*) AS class_count
				FROM schedule
				GROUP BY classroom
			) AS counts
	);
	
	
--Task55
DELETE FROM company AS comp
WHERE comp.id IN (
		SELECT company
		FROM trip
		GROUP BY Trip.company
		HAVING COUNT(*) = (
				SELECT MIN(trip_count)
				FROM (
						SELECT COUNT(*) AS trip_count
						FROM trip
						GROUP BY Trip.company
					) AS counts
			)
	);
	
	
--Task58
INSERT INTO reviews (id, reservation_id, rating)
VALUES (
		(
			SELECT COUNT(*) + 1
			FROM reviews
		),
		(
			SELECT res.id
			FROM reservations AS res
				JOIN rooms ON res.room_id = rooms.id
				JOIN users ON res.user_id = users.id
			WHERE rooms.address = '11218, Friel Place, New York'
				AND users.name = 'George Clooney'
			LIMIT 1
		), 5
	);
	
	
--Task60
SELECT sche.teacher
FROM schedule AS sche
	INNER JOIN class ON sche.class = class.id
WHERE class.name LIKE '11%'
GROUP BY sche.teacher
HAVING COUNT(DISTINCT class.id) = (
		SELECT COUNT(*)
		FROM class
		WHERE name LIKE '11%'
	);
	
	
--Task68
SELECT res.room_id,
	res.end_date,
	users.name
FROM Reservations AS res
	JOIN (
		SELECT room_id,
			MAX(end_date) AS max_end_date
		FROM Reservations
		GROUP BY room_id
	) AS last_rent ON res.room_id = last_rent.room_id
	AND res.end_date = last_rent.max_end_date
	JOIN Users ON res.user_id = Users.id;
	
--Task69
--Task71