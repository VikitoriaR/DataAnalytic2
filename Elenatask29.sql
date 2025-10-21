SELECT Passenger.name
from Passenger
INNER JOIN Pass_in_trip ON Passenger.id=Pass_in_trip.passenger
INNER JOIN Trip ON Pass_in_trip.trip=Trip.id
WHERE trip.town_to = 'Moscow' AND trip.plane = 'TU-134'
GROUP by Passenger.name