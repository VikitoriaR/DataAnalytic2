SELECT DISTINCT p.name
FROM passenger p
JOIN pass_in_trip pit ON p.id = pit.passenger
JOIN trip t ON pit.trip = t.id
WHERE t.town_to = 'Moscow'
  AND t.plane = 'TU-134';