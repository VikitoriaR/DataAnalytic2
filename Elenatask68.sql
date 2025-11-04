SELECT room_id, name, end_date
from Reservations R1
    LEFT join Users on Users.id =R1.user_id
    WHERE R1.end_date = (
    SELECT MAX(R2.end_date)
    FROM Reservations R2
    WHERE R2.room_id = R1.room_id
);