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




