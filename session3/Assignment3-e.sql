USE StoreFront;



-- Create a view displaying the order information (Id, Title, Price, Shopper’s name, Email, Orderdate,
-- Status) with latest ordered items should be displayed first for last 60 days.
CREATE VIEW OrderInformation AS
SELECT O.OrderID, O.TotalAmount, U.Name AS Shopper,U.Email, O.OrderDate,OI.OrderItemID,
P.Name As OrderItemName,
OI.Status AS ProductStatus,
OI.Quantity AS Quantity
From `Order` O
JOIN User U
ON O.UserID = U.UserID
JOIN OrderItem OI
ON O.OrderID = OI.OrderID
JOIN Product P
ON OI.ProductID = P.ProductID
Order BY O.OrderDate DESC
;

SELECT * FROM OrderInformation;

-- Use the above view to display the Products(Items) which are in ‘shipped’ state.
SELECT * FROM OrderInformation
WHERE ProductStatus = "Shipped" ;


-- Use the above view to display the top 5 most selling products.
SELECT OrderItemName, SUM(Quantity) 
FROM OrderInformation
GROUP BY OrderItemName
ORDER BY SUM(Quantity)  DESC
LIMIT 3
;


