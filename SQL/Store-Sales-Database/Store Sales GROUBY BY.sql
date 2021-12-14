SET LINESIZE 32000;
SET PAGESIZE 60;

-- Example 1 With Group BY Clause
-- Summarize sum of store sales for USA and Canada in 2016 by store zip and month
-- Only include groups with more than one row

SELECT StoreZip, TimeMonth, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear = 2016
 GROUP BY StoreZip, TimeMonth
 HAVING COUNT(*) > 1
 ORDER BY StoreZip, TimeMonth;
 
