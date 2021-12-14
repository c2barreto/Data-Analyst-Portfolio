SET LINESIZE 32000;
SET PAGESIZE 60;

-- RANK OVER, DENSE RANK, & PARTITIONS
-- Example 1
SELECT CustState, CustName, SUM(SalesDollar) AS SumSales,
  RANK() OVER (PARTITION BY CustState 
               ORDER BY SUM(SalesDollar) DESC) SalesRank
  FROM SSSales, SSCustomer
  WHERE SSSales.CUSTID = SSCustomer.CUSTID
 GROUP BY CustState, CustName
 ORDER BY CustState;

-- Example 2

SELECT CustZip, SUM(SalesUnits) AS SumSalesUnits,
  RANK() OVER (ORDER BY SUM(SalesUnits) DESC) SURank,
  DENSE_RANK() OVER (ORDER BY SUM(SalesUnits) DESC) SUDenseRank,
  NTILE(4) OVER (ORDER BY SUM(SalesUnits) DESC) SUNTile,
  ROW_NUMBER() OVER (ORDER BY SUM(SalesUnits) DESC) SURowNum
 FROM SSSales, SSCustomer
 WHERE SSSales.CUSTID = SSCustomer.CUSTID
 GROUP BY CustZip;

--Example 3
-- Rank brands on number of sales rows partitioned by year
-- Remove brands with less than or equal to 5 sales in a year
SELECT ItemBrand, TimeYear, COUNT(*) AS RowCount,
  RANK() OVER (PARTITION BY TimeYear 
               ORDER BY COUNT(*) DESC) AS RankRowCount,
  DENSE_RANK() OVER (PARTITION BY TimeYear 
               ORDER BY COUNT(*) DESC) AS DRankRowCount
  FROM SSSales, SSItem, SSTimeDim
  WHERE SSSales.ItemID = SSItem.ItemId AND SSSales.TimeNo = SSTimeDim.TimeNo
  GROUP BY ItemBrand, TimeYear
  HAVING COUNT(*) > 5;


--Example 4
-- Rank brands on sum of 2014 sales partitioned by month
-- Use both ranking functions 
SELECT ItemBrand, TimeMonth, SUM(SalesDollar) AS SumSales,
  RANK() OVER (PARTITION BY TimeMonth 
               ORDER BY SUM(SalesDollar) DESC) AS RankSumSales,
  DENSE_RANK() OVER (PARTITION BY TimeMonth 
               ORDER BY SUM(SalesDollar) DESC) AS DRankSumSales
  FROM SSSales, SSItem, SSTimeDim
  WHERE SSSales.ItemID = SSItem.ItemId AND SSSales.TimeNo = SSTimeDim.TimeNo
    AND TimeYear = 2014
  GROUP BY ItemBrand, TimeMonth;