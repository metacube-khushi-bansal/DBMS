CREATE DATABASE StoreFront ;
USE StoreFront;

CREATE TABLE Product (
ProductID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(50) NOT NULL,
StockQuantity INT NOT NULL,
Price DOUBLE
);

CREATE TABLE Image(
ImageID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
ImageUrl VARCHAR(100) NOT NULL,
AltText VARCHAR(100) ,
ProductID INT,
 CONSTRAINT FK_Product_Image FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);

CREATE TABLE Category(
CategoryID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
CategoryName VARCHAR(50) NOT NULL,
ParentCategoryID INT,
CONSTRAINT FK_ParentCategory FOREIGN KEY (ParentCategoryID)
    REFERENCES Category(CategoryID)
);

CREATE TABLE ProductCategory(
ProductCategoryID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
ProductID INT NOT NULL,
CategoryID INT NOT NULL,
CONSTRAINT FK_Product_ProductCategory FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID),
CONSTRAINT FK_Category_ProductCategory FOREIGN KEY (CategoryID)
    REFERENCES Category(CategoryID));

CREATE TABLE User(
UserID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(50) NOT NULL,
MobileNumber VARCHAR(50) NOT NULL,
Email VARCHAR(100) ,
Role ENUM ('Shopper', 'Administrator') NOT NULL
);

CREATE TABLE ShippingAdress(
ShippingAdressID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Street VARCHAR(50) NOT NULL,
State VARCHAR(50) NOT NULL,
Zipcode INT NOT NULL,
UserID INT NOT NULL,
CONSTRAINT FK_User_ShippingAddress FOREIGN KEY (UserID)
    REFERENCES User(UserID)
);


CREATE TABLE `Order` (
OrderID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
OrderDate Date NOT NULL,
UserID INT NOT NULL,
ShippingAdressID INT NOT NULL,
TotalAmount Double NOT NULL,
CONSTRAINT FK_User_Order FOREIGN KEY (UserID)
    REFERENCES User(UserID),
CONSTRAINT FK_ShippingAddress_Order FOREIGN KEY (ShippingAdressID)
    REFERENCES ShippingAdress(ShippingAdressID));

CREATE TABLE OrderItem (
OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT NOT NULL,
ProductID INT NOT NULL,
Quantity INT NOT NULL,
Status ENUM ('Shipped', 'Canceled', 'Returned', 'Completed') NOT NULL,
CONSTRAINT FK_Order_OrderItem FOREIGN KEY (OrderID)
    REFERENCES `Order`(OrderID),
CONSTRAINT FK_Product_OrderItem FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);

-- To display all the tables present in db STOREFRONT
SHOW TABLES;

-- To remove the Product Table from the Database
-- ALTER TABLE Image DROP FOREIGN KEY FK_ProductImage;
-- ALTER TABLE ProductCategory DROP FOREIGN KEY FK_Product_ProductCategory;
-- ALTER TABLE OrderItem DROP FOREIGN KEY FK_Product_OrderItem;
 SET FOREIGN_KEY_CHECKS = 0;
 DROP TABLE Product; 
 SET FOREIGN_KEY_CHECKS = 1; 
 

-- again adding the Product table to the database
CREATE TABLE Product (
ProductID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(50) NOT NULL,
StockQuantity INT NOT NULL,
Price DOUBLE
);

-- adding the ForeignKey Constraints again
ALTER TABLE Image 
ADD CONSTRAINT FK_Product_Image FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID);
    
ALTER TABLE ProductCategory 
ADD CONSTRAINT FK_Product_ProductCategory FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)   ; 



-- adding status in product table
ALTER TABLE Product
ADD Status ENUM('Active', 'Inactive') DEFAULT 'Active';
