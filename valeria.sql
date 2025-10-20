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