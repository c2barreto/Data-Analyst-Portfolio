-- Multiple table INSERT examples

-- Create Product Sale table

Create table ProductSale
( Product_ID int not null,
ProductName varchar2(50),
ProductCategory varchar2(50),
Qtr1 int,
Qtr2 int,
Qtr3 int,
Qtr4 int
);


-- Insert records into ProductSales table
INSERT INTO ProductSale VALUES ( 101, 'Television', 'Electronics', 500,4000,200,3000);
INSERT INTO ProductSale VALUES ( 102, 'Laptop', 'Electronics', 400,7000,34,567);
INSERT INTO ProductSale VALUES ( 103, 'Mobile', 'Electronics', 879,56473,44,100);
INSERT INTO ProductSale VALUES ( 104, 'Fiction', 'Books', 500,4000,444,235);
INSERT INTO ProductSale VALUES ( 105, 'Literature', 'Books', 8000,760,500,200);
INSERT INTO ProductSale VALUES ( 106, 'Horror', 'Movies', 400,3000,200,245);
INSERT INTO ProductSale VALUES ( 107, 'Action', 'Movies', 350,5000,489,2000);
INSERT INTO ProductSale VALUES ( 108, 'Thriller', 'Movies', 3090,50,300,450);
INSERT INTO ProductSale VALUES ( 109, 'Family Drama', 'Movies', 6000,300,450,200);

-- Creating tables for INSERT ALL (unconditional)
-- Create QTR1Sale table

Create table QTR1Sale
(
Product_ID int not null,
ProductName varchar2(50),
ProductCategory varchar2(50),
Qtr1 int
);
-- Create QTR2Sale table 
Create table Qtr2Sale
(
Product_ID int not null,
ProductName varchar2(50),
ProductCategory varchar2(50),
Qtr2 int
);

-- Create QTR3Sale table
Create table Qtr3Sale
(
Product_ID int not null,
ProductName varchar2(50),
ProductCategory varchar2(50),
Qtr3 int
);
-- Create QTR4Sale table
Create table Qtr4Sale
(
Product_ID int not null,
ProductName varchar2(50),
ProductCategory varchar2(50),
Qtr4 int
);

-- INSERT ALL(unconditional)
INSERT ALL
INTO QTR1Sale VALUES (Product_ID,ProductName,ProductCategory,Qtr1 )
INTO QTR2Sale VALUES (Product_ID,ProductName,ProductCategory,Qtr2 )
INTO QTR3Sale VALUES (Product_ID,ProductName,ProductCategory,Qtr3 )
INTO QTR4Sale VALUES (Product_ID,ProductName,ProductCategory,Qtr4 )

SELECT * FROM ProductSale;

-- Checking records in all tablesSelect * from QTR1Sale;
Select * from QTR1Sale;
Select * from QTR2Sale;
Select * from QTR3Sale;
Select * from QTR4Sale; 

-- Creating tables for Conditional Insert ALL
-- Create ElectronicsSale table
Create table ElectronicsSale
(Product_ID int not null,
ProductName varchar2(50),
ProductCategory varchar2(50),
TotalSales int);

-- Create BooksSale table
Create table BooksSale
(Product_ID int not null,
ProductName varchar2(50),
ProductCategory varchar2(50),
TotalSales int);

-- Create MoviesSale table
Create table MoviesSale
(Product_ID int not null,
ProductName varchar2(50),
ProductCategory varchar2(50),
TotalSales int);

--Conditional Insert FIRST
INSERT FIRST
WHEN (ProductCategory = 'Electronics') THEN
INTO ElectronicsSale VALUES (Product_ID,ProductName,ProductCategory,(Qtr1+Qtr2+Qtr3+Qtr4) )
WHEN (ProductCategory = 'Movies') THEN
INTO MoviesSale VALUES (Product_ID,ProductName,ProductCategory,(Qtr1+Qtr2+Qtr3+Qtr4) )
WHEN (ProductCategory = 'Books') THEN
INTO BooksSale VALUES (Product_ID,ProductName,ProductCategory,(Qtr1+Qtr2+Qtr3+Qtr4) )

SELECT * FROM ProductSale;

-- Checking records in all tables
Select * from ElectronicsSale;
Select * from MoviesSale;
Select * from BooksSale;

-- Creating tables for Conditional Insert FIRST
-- Create YEAR_LOW_SALES table
Create table YEAR_LOW_SALES
(Product_ID int not null,
ProductName varchar2(50),
TotalSales int);

-- Create YEAR_MID_SALES table
Create table YEAR_MID_SALES
(Product_ID int not null,
ProductName varchar2(50),
TotalSales int);

-- Create YEAR_HIGH_SALES table
Create table YEAR_HIGH_SALES 
(Product_ID int not null,
ProductName varchar2(50),
TotalSales int);

-- Conditional Insert FIRST

INSERT FIRST
WHEN (Qtr1+Qtr2+Qtr3+Qtr4 < 4000) THEN
INTO YEAR_LOW_SALES VALUES (Product_ID, ProductName, Qtr1+Qtr2+Qtr3+Qtr4 )
WHEN (Qtr1+Qtr2+Qtr3+Qtr4 > 4000 and Qtr1+Qtr2+Qtr3+Qtr4 <= 7000) THEN
INTO YEAR_MID_SALES VALUES (Product_ID, ProductName, Qtr1+Qtr2+Qtr3+Qtr4 )
ELSE
INTO YEAR_HIGH_SALES VALUES (Product_ID, ProductName, Qtr1+Qtr2+Qtr3+Qtr4 )

SELECT Product_ID, ProductName, Qtr1, Qtr2, Qtr3, Qtr4 FROM PRODUCTSALE;

-- Checking records in all tables
select * from YEAR_HIGH_SALES;
select * from YEAR_MID_SALES;
select * from YEAR_LOW_SALES;

Drop table QTR1Sale;
Drop table Qtr2Sale;
Drop table Qtr3Sale;
Drop table Qtr4Sale;

Drop table ElectronicsSale;
Drop table BooksSale;
Drop table MoviesSale;

DROP TABLE YEAR_LOW_SALES;
DROP TABLE YEAR_MID_SALES;
DROP TABLE YEAR_HIGH_SALES;

Drop table ProductSale;
