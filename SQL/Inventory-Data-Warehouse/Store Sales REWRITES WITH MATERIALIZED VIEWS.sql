SET LINESIZE 32000;
SET PAGESIZE 60;

-- Use DROP statements only if you want to rerun all examples

DROP MATERIALIZED VIEW SalesCostMV1;
DROP MATERIALIZED VIEW SalesCostMV2;
DROP MATERIALIZED VIEW SalesCostMV3;


-- Query Rewrites with Materialized Views

-- Example 1
-- Data warehouse query

SELECT StoreState, TimeYear, SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND StoreNation IN ('USA','Canada')
   AND TimeYear = 2016
 GROUP BY StoreState, TimeYear;

-- Query Rewrite: replace SSSales and SSTimeDim tables with MV1
-- Join MV1 and SSStore

SELECT DISTINCT MV1.StoreState, TimeYear, SumDollar1
FROM MV1, SSStore
WHERE MV1.StoreState = SSStore.StoreState
  AND TimeYear = 2016
  AND StoreNation IN ('USA','Canada');

-- Example 2
-- Data warehouse query
SELECT StoreState, TimeYear, SUM(SalesDollar)
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND StoreNation IN ('USA','Canada')
   AND TimeYear BETWEEN 2014 and 2017
 GROUP BY StoreState, TimeYear;

-- Query Rewrite
-- Using union of MV1, MV2, and MV3
-- Assumes that StoreCity -> StoreNation

SELECT DISTINCT MV1.StoreState, TimeYear, SumDollar1 AS StoreSales
FROM MV1, SSStore
WHERE MV1.StoreState = SSStore.StoreState
  AND TimeYear <= 2017
  AND StoreNation IN ('USA','Canada')
UNION
SELECT StoreState, TimeYear, SUM(SumDollar2) as StoreSales
FROM MV2
WHERE TimeYear = 2014
GROUP BY StoreState, TimeYear
UNION
SELECT DISTINCT StoreState, TimeYear, SUM(SumDollar3) as StoreSales
FROM MV3, SSStore
WHERE MV3.StoreCity = SSStore.StoreCity
  AND TimeYear = 2014 AND StoreNation = 'Canada'
GROUP BY StoreState, TimeYear;

-- Example 2 revised
-- Adds CUBE to Example 2
-- Data warehouse query
SELECT StoreState, TimeYear, SUM(SalesDollar)
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND StoreNation IN ('USA','Canada')
   AND TimeYear BETWEEN 2014 and 2017
 GROUP BY CUBE(StoreState, TimeYear);

-- Query Rewrite
-- Using union of MV1, MV2, and MV3
-- CUBE after union operations
-- Assumes that StoreCity -> StoreNation

SELECT StoreState, TimeYear, SUM(StoreSales) as SumStoreSales
 FROM (
  SELECT DISTINCT MV1.StoreState, TimeYear, SumDollar1 AS StoreSales
   FROM MV1, SSStore
   WHERE MV1.StoreState = SSStore.StoreState
     AND TimeYear <= 2017
     AND StoreNation IN ('USA','Canada')
 UNION
  SELECT StoreState, TimeYear, SUM(SumDollar2) as StoreSales
   FROM MV2
   WHERE TimeYear = 2014
   GROUP BY StoreState, TimeYear
 UNION
  SELECT DISTINCT StoreState, TimeYear, SUM(SumDollar3) as StoreSales
   FROM MV3, SSStore
   WHERE MV3.StoreCity = SSStore.StoreCity
     AND TimeYear = 2014 AND StoreNation = 'Canada' 
   GROUP BY StoreState, TimeYear ) X
GROUP BY CUBE(StoreState, TimeYear);

-- Example 4
-- Additional problem not shown in slides
-- Data warehouse query

SELECT CustZip, TimeYear, 
       SUM(SalesCost)/SUM(SalesUnits) AS SumUnitCost 
 FROM SSSales, SSCustomer, SSTimeDim
 WHERE SSSales.CustId = SSCustomer.CustId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND TimeYear = 2016
   AND CustNation IN ('USA','Canada')
GROUP BY CustZip, TimeYear;

-- Query Rewrite: replace Sales and Time tables with SalesCostMV1
-- Rewrite using SalesCostMV1
-- Assumes that CustZip -> CustNation

SELECT DISTINCT SMV1.CustZip, TimeYear, 
       SumCost1/SumUnits1 AS SumUnitCost
FROM SalesCostMV1 SMV1, SSCustomer
WHERE SMV1.CustZip = SSCustomer.CustZip
  AND TimeYear = 2016
  AND CustNation IN ('USA','Canada');

-- Example 5
-- Data warehouse query
SELECT CustZip, TimeYear,
       SUM(SalesCost)/SUM(SalesUnits) AS SumUnitCost 
 FROM SSSales, SSCustomer, SSTimeDim
 WHERE SSSales.CustId = SSCustomer.CustId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND TimeYear > 2015
   AND CustNation IN ('USA','Canada')
GROUP BY CustZip, TimeYear;

-- Query Rewrite using all three MVs
-- Assumes that CustZip -> CustNation in first part of the rewritten query
-- Need GROUP BY in second subquery to rollup totals from quarters to years.

SELECT SMV1.CustZip, TimeYear, 
       SumCost1/SumUnits1 AS SumUnitCost
 FROM SalesCostMV1 SMV1, SSCustomer
 WHERE SMV1.CustZip = SSCustomer.CustZip
   AND TimeYear = 2016
 AND CustNation IN ('USA','Canada')
UNION
SELECT SMV2.CustZip, TimeYear,
       SUM(SumCost2)/SUM(SumUnits2) AS SumUnitCost
 FROM SalesCostMV2 SMV2, SSCustomer
 WHERE SMV2.CustZip = SSCustomer.CustZip
   AND TimeYear > 2016
 GROUP BY SMV2.CustZip, TimeYear
UNION
SELECT SMV3.CustZip, TimeYear,
       SumCost3/SumUnits3 AS SumUnitCost
 FROM SalesCostMV3 SMV3
 WHERE TimeYear > 2016;

-- Example 6
-- Variation of example 5 with a cube operation
-- Data warehouse query

SELECT CustZip, TimeYear,
       SUM(SalesCost)/SUM(SalesUnits) AS SumUnitCost 
 FROM SSSales, SSCustomer, SSTimeDim
 WHERE SSSales.CustId = SSCustomer.CustId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND TimeYear > 2015
   AND CustNation IN ('USA','Canada')
GROUP BY CUBE(CustZip, TimeYear);

-- Query Rewrite using all three MVs
-- Assumes that CustZip -> CustNation in first part of the rewritten query
-- Since original query generates the unit cost, the subqueries must generate
-- components (sum of costs) and sum of units. The outer query then applies cube operator.

SELECT CustZip, TimeYear, SUM(SumCost)/SUM(SumUnits) AS SumUnitCost
FROM 
(
SELECT SMV1.CustZip, TimeYear, 
       SumCost1 AS SumCost, SumUnits1 AS SumUnits
 FROM SalesCostMV1 SMV1, SSCustomer
 WHERE SMV1.CustZip = SSCustomer.CustZip
   AND TimeYear = 2016
 AND CustNation IN ('USA','Canada')
UNION
SELECT SMV2.CustZip, TimeYear,
       SUM(SumCost2) AS SumCost, SUM(SumUnits2) AS SumUnits
 FROM SalesCostMV2 SMV2, SSCustomer
 WHERE SMV2.CustZip = SSCustomer.CustZip
   AND TimeYear > 2016
 GROUP BY SMV2.CustZip, TimeYear
UNION
SELECT SMV3.CustZip, TimeYear,
       SumCost3 AS SumCost, SumUnits3 AS SumUnits
 FROM SalesCostMV3 SMV3
 WHERE TimeYear > 2016
) X
GROUP BY CUBE(CustZip, TimeYear);