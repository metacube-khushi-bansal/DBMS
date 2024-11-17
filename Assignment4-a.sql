-- Create a function to calculate number of orders in a month. 
-- Month and year will be input parameter to function.
DELIMITER //
CREATE FUNCTION 
 CountOfOrdersInaMonth (input_month INT , input_year INT) 
 RETURNS INT
 DETERMINISTIC
 BEGIN
      DECLARE order_count INT;
      SELECT COUNT(*) INTO order_count
      FROM `order`
      WHERE MONTH(OrderDate) = input_month
      AND YEAR(OrderDate)  = input_year;
      
      RETURN order_count;
END;
//
DELIMITER ;

SELECT CountOfOrdersInaMonth(11,2024) As OrderCount;

DELIMITER //
-- Create a function to return month in a year having maximum orders. Year will be input parameter.
CREATE FUNCTION 
GetMonthHavingMaximumOrderInYear (input_year INT) 
RETURNS INT
DETERMINISTIC
BEGIN
      DECLARE max_month INT;
      SELECT MONTH(OrderDate) INTO max_month
      FROM `order`
      WHERE YEAR(OrderDate) = input_year
      GROUP BY MONTH(OrderDate)
      ORDER BY COUNT(*) DESC
      LIMIT 1;
      
      RETURN max_month;
END;
//
DELIMITER ;

SELECT GetMonthHavingMaximumOrderInYear(2024) As Max_Month;



-- Create a Stored procedure to retrieve average sales of each product in a month. 
-- Month and year will be input parameter to function.
DELIMITER &&
CREATE PROCEDURE GetAverageSales ( IN Input_month INT, IN input_year INT)
BEGIN
SELECT p.Name, AVG(p.Price * oi.Quantity) As AverageSale
FROM OrderItem oi
JOIN Product p
ON oi.ProductID = p.ProductID
JOIN `Order` o
ON o.OrderID = oi.OrderID
WHERE MONTH(o.OrderDate) = Input_month AND YEAR(o.orderDate) = input_year
GROUP BY p.Name;
END &&
DELIMITER ;

CALL GetAverageSales(11,2024);

-- Create a stored procedure to retrieve table having order detail with status for a given period.
-- Start date and end date will be input parameter. Put validation on input dates like start date is
-- less than end date. If start date is greater than end date take first date of month as start date.

DELIMITER &&
CREATE PROCEDURE GetOrderDetails
(IN StartDate DATE,
 IN EndDate DATE
 )
 BEGIN
     IF StartDate > EndDate THEN
       SET StartDate =   DATE_SUB(EndDate, INTERVAL DAY(EndDate) - 1 DAY);
       END IF;
       
       SELECT o.OrderID, o.UserID, o.OrderDate,oi.OrderItemID, oi.Status,p.Name,o.TotalAmount
       FROM `Order`o
       JOIN OrderItem oi 
       ON o.OrderID = oi.OrderID
       JOIN Product p
       ON oi.ProductID = p.ProductID
       WHERE OrderDate BETWEEN StartDate AND EndDate;
       
END &&
DELIMITER ;

DROP PROCEDURE GetOrderDetails;
CALL GetOrderDetails('2024-11-01', '2024-11-17');
       

