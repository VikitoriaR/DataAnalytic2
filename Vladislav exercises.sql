exercises 44

SELECT
    MAX(EXTRACT(YEAR FROM AGE(NOW(), stu.birthday))) AS max_year
FROM student AS stu
JOIN student_in_class AS sicl ON stu.id = sicl.student
JOIN class AS cls ON cls.id = sicl.class
WHERE cls.name LIKE '10%';


exercises 45

SELECT sch.classroom
FROM schedule AS sch
GROUP BY sch.classroom
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM schedule AS sch2
        GROUP BY sch2.classroom
    ) AS sub
);


exercises 60

SELECT sch.teacher
FROM schedule AS sch
JOIN class AS cls ON sch.class = cls.id
WHERE cls.name LIKE '11%'
GROUP BY sch.teacher
HAVING COUNT(DISTINCT cls.id) = (
    SELECT COUNT(*) 
    FROM class AS cls2 
    WHERE cls2.name LIKE '11%'
);


exercises 55

DELETE FROM Company AS comp
WHERE comp.id IN (
    SELECT trip.company
    FROM Trip AS trip
    GROUP BY trip.company
    HAVING COUNT(*) = (
        SELECT MIN(cnt)
        FROM (
            SELECT COUNT(*) AS cnt
            FROM Trip AS tripstat
            GROUP BY tripstat.company
        ) AS statsub
    )
);


exercises 58

INSERT INTO reviews (id, reservation_id, rating)
VALUES (
    (SELECT COUNT(*) + 1 FROM reviews AS revws),                  
    (SELECT resrv.id
     FROM reservations AS resrv
     JOIN rooms AS rooms ON rooms.id = resrv.room_id
     JOIN users AS users ON users.id = resrv.user_id
     WHERE rooms.address = '11218, Friel Place, New York'
       AND users.name = 'George Clooney'
     LIMIT 1),                                                   
    5                                                            
);


exercises 68

SELECT 
    rooms.id AS room_id,
    users.name,
    resrv.end_date AS end_date
FROM reservations AS resrv
JOIN users AS users ON users.id = resrv.user_id
JOIN rooms AS rooms ON rooms.id = resrv.room_id
WHERE resrv.end_date = (
    SELECT MAX(subrs.end_date)
    FROM reservations AS subrs
    WHERE subrs.room_id = resrv.room_id
)
ORDER BY rooms.id;



exercises 69

SELECT 
    rmown.owner_id AS owner_id,
    COALESCE(SUM(resrv.total), 0) AS total_earn
FROM rooms AS rmown
LEFT JOIN reservations AS resrv 
    ON rmown.id = resrv.room_id
GROUP BY rmown.owner_id
ORDER BY total_earn DESC;


exercises 71

SELECT 
    ROUND(
        100.0 * COUNT(DISTINCT actus.user_id) 
        / (SELECT COUNT(*) FROM users),
        2
    ) AS percent
FROM (
    SELECT resrv.user_id
    FROM reservations AS resrv
    UNION
    SELECT roomr.owner_id AS user_id
    FROM rooms AS roomr
) AS actus;