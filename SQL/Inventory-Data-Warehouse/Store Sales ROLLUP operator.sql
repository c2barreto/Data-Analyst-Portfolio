SET LINESIZE 32000;
SET PAGESIZE 60;

-- ROLLUP operator
-- Example 1.
SELECT TimeYear, TimeMonth, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
 GROUP BY ROLLUP(TimeYear, TimeMonth)
 ORDER BY TimeYear, TimeMonth;

-- Example 2. 
-- Rewrite of query 3 using the UNION operator
SELECT TimeYear,TimeMonth, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
GROUP BY TimeYear, TimeMonth
UNION
SELECT TimeYear, NULL, SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
GROUP BY TimeYear
UNION
SELECT NULL, NULL, SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
  ORDER BY 1, 2;

-- Example 3.
SELECT TimeYear, TimeQuarter, TimeMonth, 
       SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
 GROUP BY ROLLUP(TimeYear, TimeQuarter, TimeMonth)
 ORDER BY TimeYear, TimeQuarter, TimeMonth;

-- Example 4.
-- Rewrite of query 3 using the UNION operator
SELECT TimeYear, TimeQuarter, TimeMonth, 
       SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
GROUP BY TimeYear, TimeQuarter, TimeMonth
UNION
SELECT TimeYear, TimeQuarter, 0, SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
GROUP BY TimeYear, TimeQuarter
UNION
SELECT TimeYear, 0, 0, SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
GROUP BY TimeYear
UNION
SELECT 0, 0, 0, SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
 ORDER BY 1, 2, 3;