USE  StoreFront;

INSERT INTO User(Name, MobileNumber, Email, Role) values
('John Doe', '8398735468', 'john.doe@gmail.com', 'Shopper'),
('Aditya Kumar', '9873546823', 'aditya.kumar@gmail.com', 'Shopper'),
('Khushi', '8989354682', 'khushi@gmail.com', 'Administrator');

INSERT INTO User(Name, MobileNumber, Email, Role) values
('Divya Gupta', '673672832', 'divya.gupta@gmail.com', 'Shopper'),
('Rohan joshi', '8735468239', 'rohan.joshi@gmail.com', 'Shopper'),
('Amit Sharma', '8893542682', 'amit.sharma@gmail.com', 'Shopper');

SELECT * FROM User;

INSERT INTO Category (CategoryName, ParentCategoryID) VALUES
('Electronics', NULL),
('Clothing', NULL),
('Mobile Phones', 1),
('Laptops', 1),
('Men Clothing', 2),
('Women Clothing', 2);

-- Insert sample data into Product table
INSERT INTO Product ( Name, Price, StockQuantity) VALUES
('iPhone 14', 80000, 50),
('MacBook Pro', 99000, 30),
('Men T-Shirt', 799, 100);

-- Insert sample data into Image table
INSERT INTO Image (ImageURL, ProductID, AltText) VALUES
('https://example.com/images/phone.jpg', 1, 'Phone Image'),
('https://example.com/images/laptop.jpg', 2, 'Laptop Image'),
('https://example.com/images/tshirt.jpg', 3, 'Tshirt Image');


-- Insert sample data into ProductCategory table (many-to-many relationship between Product and Category)
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES
(1, 3), -- iPhone 12 in Mobile Phones
(2, 4), -- MacBook Pro in Laptops
(3, 5); -- Men T-Shirt in Men Clothing


-- Insert sample data into ShippingAddress table
INSERT INTO ShippingAdress (UserID, Street, State, ZipCode) VALUES
(1, '23 Tonk Road', 'Jaipur', '302015'),
(2, '23 Ratanada', 'Jodhpur', '342011');


INSERT INTO ShippingAdress (UserID, Street, State, ZipCode) VALUES
(4, '11 High Street', 'Udaipur', '322001'),
(5, '01 Mangal Vihar', 'Jaipur', '302014'),
(6, '11 Lions Street', 'Bombay', '223311');

-- Insert sample data into Order table
INSERT INTO `Order` (UserID, ShippingAdressID, TotalAmount, OrderDate) VALUES
(1, 1, 99999, '2024-11-10'),
(2, 2, 1600, '2024-11-11');

INSERT INTO `Order` (UserID, ShippingAdressID, TotalAmount, OrderDate) VALUES
(4, 3, 133000 ,'2022-05-10'),
(5, 4, 63000 , '2024-11-11'),
(6, 5, 2400, '2023-10-08');

SELECT * FROM Product;
SELECT * FROM `Order`;
-- Insert sample data into OrderItem table
INSERT INTO OrderItem (OrderID, ProductID, Quantity, Status) VALUES
(1, 2, 1, 'Shipped'), -- Status- Macbook in order 1
(2, 3, 2, 'Completed'); -- Men T-Shirt in order 2

INSERT INTO OrderItem (OrderID, ProductID, Quantity, Status) VALUES
(3, 4, 2, 'Shipped'), -- Status- s23 ,2  in order 3
(3, 5, 1, 'Completed'); -- pavilion 14 in order 3

INSERT INTO OrderItem (OrderID, ProductID, Quantity, Status) VALUES
(4, 5, 1, 'Shipped'), -- Status- paviiloion 14  in order 4
(5, 3, 2, 'Completed'); -- pavilion 14 in order 3

-- 2. Display Id, Title, Category Title, Price of the products which are Active  
-- and recently added products should be at top.
SELECT P.ProductID, P.Name, P.Price, C.CategoryID , C.CategoryName
FROM Product P
INNER JOIN ProductCategory
ON P.ProductID = ProductCategory.ProductID
INNER JOIN Category C
ON ProductCategory.CategoryID = C.CategoryID
WHERE P.Status = 'Active'
ORDER BY P.ProductID DESC;

-- 3. Display the list of products which don't have any images.
INSERT INTO Product ( Name, Price, StockQuantity) VALUES
('Samsung Galaxy S23', 35000, 40),  -- dont have any image associated with them
('HP Pavilion 14', 63000, 20); --  dont have any img associated with it

INSERT INTO ProductCategory (ProductID, CategoryID) VALUES
(4, 4), -- S23 in Mobile Phones
(5, 5); -- Pavilion 14 in Laptops

SELECT * FROM Product;

SELECT * FROM Image;

SELECT P.ProductID, P.Name, Image.ImageID
FROM Product P
LEFT JOIN Image
ON P.ProductID = Image.ProductID
WHERE ImageID IS NULL;


-- Display all Id, Title and Parent Category Title for all 
-- the Categories listed, sorted by Parent Category Title and 
-- then Category Title. (If Category is top category then Parent Category 
-- Title column should display “Top Category” as value.)
SELECT C.CategoryID, C.CategoryName As Title,
COALESCE (PC.CategoryName,'Top Category') AS ParentCategoryTitle
FROM Category C
LEFT JOIN Category PC
ON C.ParentCategoryID = PC.CategoryID
ORDER BY ParentCategoryTitle, Title;

SELECT * FROM Category;

-- Display Id, Title, Parent Category Title of all the leaf Categories 
-- (categories which are not parent of any other category)
SELECT C.CategoryID, C.CategoryName
FROM Category C
LEFT JOIN Category PC 
ON C.CategoryID = PC.ParentCategoryID
WHERE PC.ParentCategoryID IS NULL;


-- Display the list of Products whose Quantity on hand (Inventory) is under 50.
SELECT *
FROM Product
WHERE StockQuantity <50; 

-- Display Product Title, Price & Description which falls into particular
-- category Title (i.e. “Mobile”)
SELECT P.ProductID, Name, Price, C.CategoryName
FROM Product P
INNER JOIN ProductCategory PC
ON P.ProductID = PC.ProductID
INNER JOIN Category C
ON PC.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Laptops';