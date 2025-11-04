DELETE  FROM Company
Where Company.id IN (
       SELECT Company.id
       FROM Company
            left join Trip on Trip.company=Company.id
        GROUP BY Company.id
        HAVING count(Trip.id) = (
               SELECT MIN(trip_count) 
               FROM (
                    SELECT COUNT(trip.id) AS trip_count
                    FROM company 
                    LEFT JOIN trip  ON company.id = trip.company
                    GROUP BY company.id)
              )
              )