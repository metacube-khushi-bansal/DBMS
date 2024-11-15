-- 1Display Shopper’s information along with number of orders he/she placed during last 30 days.
USE StoreFront;

SELECT U.UserID, U.Name, O.OrderID, O.OrderDate ,Count(O.OrderID)As NumberOfOrders
From User U
JOIN `Order` O
ON U.UserID  = O.OrderID
WHERE O.OrderDate > DATE_SUB(Now() , INTERVAL 30 Day) AND Role = 'Shopper'
GROUP BY U.UserID, U.Name
; 

-- 2.Display the top 10 Shoppers who generated maximum number of revenue in last 30 days.
 SELECT U.UserID, Name, O.TotalAmount
 FROM User U
 JOIN `Order` O
 ON U.UserID = O.UserID
 ORDER BY O.TotalAmount DESC
 LIMIT 3;
 
 
-- 3. Display top 20 Products which are ordered most in last 60 days along with numbers.
SELECT P.ProductID, Name, COUNT(OI.ProductID) AS OrderCount
FROM Product P
JOIN OrderItem OI
ON P.ProductID = OI.ProductID
JOIN `Order` O
ON OI.OrderID = O.OrderID
WHERE O.OrderDate> DATE_SUB(NOW(), INTERVAL 3 YEAR) 
GROUP BY P.ProductID, Name
ORDER BY OrderCount DESC
;

SELECT*FROM OrderItem;


-- 4 Display Monthly sales revenue of the StoreFront for last 6 months. It should display each 
-- month’s sale.
SELECT
DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
SUM(TotalAmount) As MonthlyRevenue
FROM `Order`
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL  6 MONTH)
GROUP BY Month
ORDER BY Month DESC;

 -- 5.Mark the products as Inactive which are not ordered in last 90 days.
 UPDATE Product
 SET Status  = 'Inactive'
 WHERE ProductID NOT IN (
 SELECT RecentOrders.ProductID
 FROM(SELECT P.ProductID
 FROM Product P 
 JOIN OrderItem OI
 ON P.ProductID = OI.ProductID
 JOIN `Order` O
 ON OI.OrderID =  O. OrderID
 WHERE O.OrderDate > DATE_SUB(NOW(), INTERVAL 90 DAY) ) AS RecentOrders );
 
 SELECT * FROM Product;
 
 -- 6. Given a category search keyword, display all the Products present in this category/categories. 
 SELECT C.CategoryID, C.CategoryName, P.Name
 FROM Category C
 JOIN ProductCategory PC
 ON C.CategoryID = PC.CategoryID
 JOIN Product P
 ON PC.ProductID = P.ProductID
 WHERE C.CategoryName = "Chocolates";
 
 -- 7. Display top 10 Items which were cancelled most.
 SELECT P.ProductID, P.Name, COUNT(*) AS CompletedMost
 FROM OrderItem OI
 JOIN Product P
 ON OI.ProductID = P.ProductID
 WHERE OI.Status = "Completed"
 GROUP BY P.ProductID, P.Name
 ORDER BY CompletedMost
 ;
 
 SELECT * FROM OrderItem;
 
 
 

SELECT * FROM Product;



SELECT * FROM `Order`;