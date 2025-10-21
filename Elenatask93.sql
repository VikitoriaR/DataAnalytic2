SELECT  AVG (aver.age) as average_age
FROM(
SELECT Customer.age
from Purchase
INNER JOIN Product ON Purchase.product_key=Product.product_key
INNER JOIN Customer ON Purchase.customer_key=Customer.customer_key
WHERE product.name = 'Smartwatch' AND YEAR(Purchase.date) = 2024
GROUP by customer.age) aver