SELECT lastname,firstname FROM customers WHERE city = "Saint-Pierre";
SELECT lastname,firstname,email FROM customers WHERE gender = "Mme";
SELECT lastname,firstname,phone FROM customers WHERE phone LIKE "0262%";
SELECT MAX(price) AS 'HIGHEST PRICE' , MIN(PRICE) AS 'LOWEST PRICE' FROM products;
SELECT * FROM `orders` WHERE orderedAt LIKE "2016%";
SELECT customers.firstname,customers.lastname,customers.email,orderedAt,orders.id AS "Order Id" FROM `orders` NATURAL JOIN customers  WHERE orderedAt LIKE "2016%";
SELECT customers.firstname,customers.lastname,customers.email,orderedAt,orders.id AS "Order Id" FROM `orders` NATURAL JOIN customers WHERE HOUR(orderedAt) BETWEEN "06" AND "12";
SELECT customers.firstname,customers.lastname,customers.email,orderedAt,orders.id AS "Order Id" FROM `orders` NATURAL JOIN customers WHERE TIME(orderedAt) BETWEEN "18:00:00" AND "23:59:00";
