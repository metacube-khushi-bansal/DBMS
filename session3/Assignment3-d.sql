USE StoreFront;
-- Consider a form where providing a Zip Code populates associated City and
-- State
--  Create appropriate tables and relationships for the same and write a SQL
--          query for that returns a Resultset containing Zip Code, City Names and
--          States ordered by State Name and City Name.
-- 	(Create 3 tables to store State, District/City & Zip code separately)

CREATE TABLE State (
Id INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(100) NOT NULL
);


CREATE TABLE City (
Id INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(100) NOT NULL Unique,
StateId INT NOT NULL,
CONSTRAINT FK_City_State FOREIGN KEY (StateId)
    REFERENCES State(Id)
);

CREATE TABLE ZipCode (
ZipCode VARCHAR(15) PRIMARY KEY,
CityId INT NOT NULL,
CONSTRAINT FK_ZipCode_City FOREIGN KEY (CityId)
    REFERENCES City(Id)
);

INSERT INTO State(Name) values
('Rajasthan'),
('Maharashtra'),
('Gujarat')
;

INSERT INTO City(Name, StateId)
VALUES
('Jaipur',1),
('Mumbai',2),
('Ahemdabad',3);

INSERT INTO ZipCode(ZipCode,CityId)
VALUES
('302015',1),
('302022',1),
('302030',1),
('400012',2),
('400015',2),
('380015',3);

SELECT * FROM State;
SELECT * FROM City;
SELECT* FROM ZipCode;

SELECT ZC.ZipCode, C.Name AS CityName, S.Name AS StateName
From ZipCode ZC
JOIN City C
ON ZC.CityId = C.ID
JOIN State S
ON C.StateId = S.ID
;