USE StoreFront;

INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES
(1,1),
(2,1),
(3,2);


SELECT * FROM Category;
INSERT INTO Category (CategoryName, ParentCategoryID) VALUES
('Food Products', NULL),
('Chocolates',6);

INSERT INTO Product ( Name, Price, StockQuantity) VALUES
('Dairy Milk', 90, 80),
('Snickers', 40,10),
('Feastables', 450, 30);

SELECT * FROM Product;
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES
(7,7),
(8,7),
(9,7);

-- 1.Display the list of products (Id, Title, Count of Categories) which fall in more than one Category.
SELECT P.ProductID, P.Name, Count(PC.CategoryID)As NumberOfCategory
From Product P
JOIN ProductCategory PC
ON P.ProductID = PC.ProductID 
GROUP BY P.ProductID, P.Name
HAVING Count(PC.CategoryID) > 1
;


SELECT * FROM Category;
SELECT * FROM Product;
-- 2.Display Count of products as per below price range: 0-100, 101-500, above

  SELECT SUM(CASE WHEN Price BETWEEN 0 AND 100 THEN 1 ELSE 0 END) As Range1
    ,  SUM(CASE WHEN Price BETWEEN 101 AND 500 THEN 1 ELSE 0 END) As Range2
    ,  SUM(CASE WHEN Price > 500 THEN 1 ELSE 0 END) As Range3
FROM Product;




-- 3. Display the Categories along with number of products under each category.
SELECT CategoryName, Count(PC.ProductID) As NumberOfProducts
FROM Category C
JOIN ProductCategory PC
ON C.CategoryID = PC.CategoryID
GROUP BY CategoryName;


