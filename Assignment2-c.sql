-- Display Recent 50 Orders placed (Id, Order Date, Order Total).
SELECT OrderID, OrderDate, TotalAmount
FROM `Order`
ORDER BY OrderDate DESC
LIMIT 3;

-- Display 10 most expensive Orders.
SELECT OrderID, OrderDate, TotalAmount
FROM `Order`	
ORDER BY TotalAmount DESC
LIMIT  3
;

-- Display all the Orders which are placed more than 10 days old and one or more items from those
-- orders are still not shipped.
SELECT O.OrderID, O.OrderDate, O.TotalAmount
From `Order` O
JOIN OrderItem OI
ON O.OrderID = OI.OrderID
WHERE OrderDate <=date_sub(CURDATE(), INTERVAL 10 DAY)
AND OI.Status != 'Shipped';

-- Display list of shoppers which haven't ordered anything since last month.
SELECT U.UserID, Name, OrderDate
FROM User U
LEFT JOIN `Order` O 
ON U.UserID = O.UserID
WHERE ROLE = 'Shopper'
AND OrderDate <= date_sub(CURDATE(), INTERVAL 1 MONTH);


-- Display list of shopper along with orders placed by them in last 15 days. 
SELECT U.UserID, Name, OrderID, OrderDate, TotalAmount
FROM User U
LEFT JOIN `Order` O 
ON U.UserID = O.UserID
WHERE ROLE = 'Shopper'
AND OrderDate >= date_sub(CURDATE(), INTERVAL 15 DAY);


-- Display list of order items which are in “shipped” state for particular Order Id (i.e.: 1020))
SELECT O.OrderID, OI.OrderItemID, OI.ProductID, P.Name, OI.Status
FROM `Order` O 
INNER JOIN OrderItem OI
ON O.OrderID = OI.OrderID
INNER JOIN Product P
ON OI.ProductID = P.ProductID
WHERE O.OrderID = 3 AND OI.Status  = 'Shipped';

-- Display list of order items along with order placed date which fall between Rs 20 to Rs 50 price.
SELECT OI.OrderID, OI.OrderItemID, OI.ProductID, P.Name, P.Price
FROM `Order` O 
INNER JOIN OrderItem OI
ON O.OrderID = OI.OrderID
INNER JOIN Product P
ON OI.ProductID = P.ProductID
WHERE P.Price >= 30000 AND P.Price <= 70000;

SELECT * FROM OrderItem;