SELECT 
    ROUND(
        100.0 * COUNT(active_users.user_id) / COUNT(users.id), 2
    ) AS percent
FROM users 
LEFT JOIN 
(
    SELECT user_id
    FROM reservations

    UNION

    SELECT r.owner_id AS user_id
    FROM rooms r
    JOIN reservations res ON r.id = res.room_id
) AS active_users
ON Users.id = active_users.user_id;