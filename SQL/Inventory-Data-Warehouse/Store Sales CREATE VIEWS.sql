SET LINESIZE 32000;
SET PAGESIZE 60;

-- Use DROP statements only if you want to rerun all examples

DROP VIEW Connex20142016Sales_View;
DROP VIEW Connex20142016SumSales_View;
DROP VIEW ColoradoCustomer2014Sales_View;

CREATE VIEW Connex20142016Sales_View AS
 SELECT SSItem.ItemId, ItemName, ItemCategory, 
        ItemUnitPrice, SalesNo, SalesUnits, 
        SalesDollar, SalesCost, TimeYear, 
        TimeMonth, TimeDay 
  FROM SSItem, SSSales, SSTimeDim
  WHERE ItemBrand = 'Connex' 
    AND TimeYear BETWEEN 2014 AND 2016
    AND SSItem.ItemId = SSSales.ItemId
    AND SSTimeDim.TimeNo = SSSales.TimeNo;
    
-- Example 2
-- View with row summaries

CREATE VIEW Connex20142016SumSales_View AS
 SELECT SSItem.ItemId, ItemName, ItemCategory, 
        ItemUnitPrice, TimeYear, TimeMonth,
        SUM(SalesDollar) AS SumSalesDollar,
        SUM(SalesCost) AS SumSalesCost
  FROM SSItem, SSSales, SSTimeDim
  WHERE ItemBrand = 'Connex' 
    AND TimeYear BETWEEN 2014 AND 2016
    AND SSItem.ItemId = SSSales.ItemId
    AND SSTimeDim.TimeNo = SSSales.TimeNo
  GROUP BY SSItem.ItemId, ItemName, ItemCategory, 
        ItemUnitPrice, TimeYear, TimeMonth;

-- Example 3
-- Query using Connex20142016Sales_View 

SELECT ItemName, ItemCategory, ItemUnitPrice, 
        SalesUnits, SalesDollar, SalesCost,
        TimeYear, TimeMonth, TimeDay 
  FROM Connex20142016Sales_View
  WHERE ItemUnitPrice < 100
    AND TimeYear BETWEEN 2015 AND 2016;

-- Example 4
-- Query using Connex20142016SumSales_View 

SELECT ItemName, ItemCategory, ItemUnitPrice, 
        TimeMonth, SumSalesDollar, SumSalesCost 
  FROM Connex20142016SumSales_View
  WHERE TimeYear = 2014;

-- Example 5
-- Modified query using the base tables only

SELECT ItemName, ItemCategory, ItemUnitPrice, 
        SalesUnits, SalesDollar, SalesCost,
        TimeYear, TimeMonth, TimeDay  
  FROM SSItem, SSSales, SSTimeDim
  WHERE ItemUnitPrice < 100
    AND ItemBrand = 'Connex' 
    AND TimeYear BETWEEN 2015 AND 2016
    AND SSItem.ItemId = SSSales.ItemId
    AND SSTimeDim.TimeNo = SSSales.TimeNo;

-- Example 6
-- Colorado customer sales in 2014
-- Display customer, item, and time columns in the result

CREATE VIEW ColoradoCustomer2014Sales_View AS
 SELECT SSCustomer.CustId, CustName, CustCity, CustZip, ItemName, ItemCategory, 
        ItemBrand, ItemUnitPrice, SalesNo, SalesUnits, 
        SalesDollar, SalesCost, TimeMonth, TimeDay    
  FROM SSItem, SSSales, SSTimeDim, SSCustomer
  WHERE CustState = 'CO' 
    AND TimeYear = 2014
    AND SSItem.ItemId = SSSales.ItemId
    AND SSTimeDim.TimeNo = SSSales.TimeNo
    AND SSCustomer.CustId = SSSales.CustId;

-- Example 7
-- Denver sales in second half of 2014
-- Display customer, item number, and time columns

SELECT CustId, CustName, CustZip, ItemName, ItemCategory, 
        ItemBrand, ItemUnitPrice, SalesNo, SalesUnits, 
        SalesDollar, SalesCost, TimeMonth, TimeDay 
  FROM ColoradoCustomer2014Sales_View
  WHERE  CustCity = 'Denver' AND TimeMonth > 6;

-- Example 8
-- Modified query

SELECT SSCustomer.CustId, CustName, CustZip, ItemName, ItemCategory, 
        ItemBrand, ItemUnitPrice, SalesNo, SalesUnits, 
        SalesDollar, SalesCost, TimeMonth, TimeDay 
  FROM SSItem, SSSales, SSTimeDim, SSCustomer
  WHERE CustState = 'CO' AND CustCity = 'Denver'
    AND TimeMonth > 6
    AND TimeYear = 2014
    AND SSItem.ItemId = SSSales.ItemId
    AND SSTimeDim.TimeNo = SSSales.TimeNo
    AND SSCustomer.CustId = SSSales.CustId;
