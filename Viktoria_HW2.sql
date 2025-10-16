with table1 as
(select cust.name, cust.age as age
from Purchase pur
INNER JOIN customer cust ON pur.customer_key = cust.customer_key
INNER JOIN product prod ON pur.product_key = prod.product_key
where pur.product_key = '6'
  and year(date) = '2024'
group by cust.name, cust.age)

select ROUND(avg(age), 2) as average_age
from table1;

