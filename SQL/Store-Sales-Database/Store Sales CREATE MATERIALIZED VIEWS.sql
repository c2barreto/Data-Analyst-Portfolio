SET LINESIZE 32000;
SET PAGESIZE 60;

-- Use DROP statements only if you want to rerun all examples
DROP MATERIALIZED VIEW MV1;
DROP MATERIALIZED VIEW MV2;
DROP MATERIALIZED VIEW MV3;

-- MATERIALIZED VIEWS

-- Example 1
-- MV for store sales after 2014 store sales by state and year
CREATE MATERIALIZED VIEW MV1
 BUILD IMMEDIATE
 REFRESH COMPLETE ON DEMAND
 ENABLE QUERY REWRITE AS
 SELECT StoreState, TimeYear, 
        SUM(SalesDollar) AS SUMDollar1
  FROM SSSales, SSStore, SSTimeDim
  WHERE SSSales.StoreId = SSStore.StoreId 
       AND SSSales.TimeNo = SSTimeDim.TimeNo
       AND TimeYear > 2014
  GROUP BY StoreState, TimeYear;

-- Example 2
-- USA store sales by store state, year, and month
-- Sum of dollar sales 

CREATE MATERIALIZED VIEW MV2
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
ENABLE QUERY REWRITE AS
SELECT StoreState, TimeYear, TimeMonth, 
       SUM(SalesDollar) AS SUMDollar2
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND StoreNation = 'USA'
 GROUP BY StoreState, TimeYear, TimeMonth;


-- Example 3
-- Canadian store sales before 2015 by store city, year, and month
-- Sum of dollar sales 

CREATE MATERIALIZED VIEW MV3
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
ENABLE QUERY REWRITE AS
SELECT StoreCity, TimeYear, TimeMonth, 
       SUM(SalesDollar) AS SUMDollar3
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND StoreNation ='Canada'
   AND TimeYear <= 2014
 GROUP BY StoreCity, TimeYear, TimeMonth;

-- Example 4
-- 2016 cost of store sales
CREATE MATERIALIZED VIEW SalesCostMV1
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
ENABLE QUERY REWRITE AS
SELECT CustZip, TimeYear, SUM(SalesUnits) AS SumUnits1, 
       SUM(SalesCost) AS SumCost1
 FROM SSSales, SSCustomer, SSTimeDim
 WHERE SSSales.CustId = SSCustomer.CustId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND TimeYear <= 2016
 GROUP BY CustZip, TimeYear;
 
 -- Example 5
 -- USA cost of store sales.
CREATE MATERIALIZED VIEW SalesCostMV2
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
ENABLE QUERY REWRITE AS
SELECT CustZip, TimeYear, TimeQuarter, SUM(SalesUnits) AS SumUnits2, 
       SUM(SalesCost) AS SumCost2
 FROM SSSales, SSCustomer, SSTimeDim
 WHERE SSSales.CustId = SSCustomer.CustId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND CustNation = 'USA'
 GROUP BY CustZip, TimeYear, TimeQuarter;
 
 -- Example 6
 -- After 2015 average cost of store sales
CREATE MATERIALIZED VIEW SalesCostMV3
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
ENABLE QUERY REWRITE AS
SELECT CustZip, TimeYear, SUM(SalesUnits) AS SumUnits3, 
       SUM(SalesCost) AS SumCost3
 FROM SSSales, SSCustomer, SSTimeDim
 WHERE SSSales.CustId = SSCustomer.CustId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND CustNation = 'Canada'
   AND TimeYear > 2015
 GROUP BY CustZip, TimeYear;
