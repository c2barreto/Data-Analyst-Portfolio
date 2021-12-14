SET LINESIZE 32000;
SET PAGESIZE 60;

--Window Comparisons: Cummulative SUMS Partitioned

-- Example 1
-- Cumulative sales by zip and year (no partitioning)

SELECT StoreZip, TimeYear,
  SUM(SalesDollar) AS SumSales, SUM(SUM(SalesDollar)) OVER 
   (ORDER BY StoreZip, TimeYear
    ROWS UNBOUNDED PRECEDING ) AS CumSumSales
 FROM SSStore, SSTimeDim, SSSales
 WHERE SSSales.StoreID = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
 GROUP BY StoreZip, TimeYear;

-- Example 2
-- Cumulative sales by zip and year; partition by zip

SELECT StoreZip, TimeYear, SUM(SalesDollar) AS SumSales,
  SUM(SUM(SalesDollar)) OVER (PARTITION BY StoreZip
    ORDER BY StoreZip, TimeYear
    ROWS UNBOUNDED PRECEDING ) AS CumSumSales
 FROM SSStore, SSTimeDim, SSSales
 WHERE SSSales.StoreID = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
 GROUP BY StoreZip, TimeYear;

-- Example 3
-- Cumulative sum of 2014 sales by item brand and month
-- Order by item brand
-- Show item brand, year, count, and sum of sales in the result

SELECT ItemBrand, TimeMonth, SUM(SalesDollar) AS SumSales,
  SUM(SUM(SalesDollar)) OVER (PARTITION BY ItemBrand
    ORDER BY ItemBrand, TimeMonth
    ROWS UNBOUNDED PRECEDING ) AS CumSumSales
  FROM SSSales, SSItem, SSTimeDim
  WHERE SSSales.ItemID = SSItem.ItemId AND SSSales.TimeNo = SSTimeDim.TimeNo
    AND TimeYear = 2014
  GROUP BY ItemBrand, TimeMonth;

-- Example 4
-- Cumulative sum of sales by year and item brand
-- Partition by year
-- Only include brands with more than 5 sales in a year
-- Show year, item brand, count, sum of sales, and cumulative sum of sales in the result

SELECT TimeYear, ItemBrand, COUNT(*) AS RowCount, SUM(SalesDollar) AS SumSales,
  SUM(SUM(SalesDollar)) OVER (PARTITION BY TimeYear
    ORDER BY ItemBrand, TimeYear
    ROWS UNBOUNDED PRECEDING ) AS CumSumSales
  FROM SSSales, SSItem, SSTimeDim
  WHERE SSSales.ItemID = SSItem.ItemId AND SSSales.TimeNo = SSTimeDim.TimeNo
  GROUP BY TimeYear, ItemBrand
  HAVING COUNT(*) > 5 ;
