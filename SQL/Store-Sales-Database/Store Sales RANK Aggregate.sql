SET LINESIZE 32000;
SET PAGESIZE 60;

-- RANK

-- Example 1: rank products by unit price
SELECT ItemId, ItemBrand, ItemUnitPrice,
  RANK() OVER ( ORDER BY ItemUnitPrice ) AS RankUnitPrice
  FROM SSItem;

-- Example 2: rank customers by descending sum of sales

SELECT CustName, SUM(SalesDollar) AS SumSales,
  RANK() OVER (ORDER BY SUM(SalesDollar) DESC) AS SumSalesRank
  FROM SSSales, SSCustomer
  WHERE SSSales.CUSTID = SSCustomer.CUSTID
 GROUP BY CustName;


-- Example 3: Rank brands by average sales in 2014 and 2015
SELECT ItemBrand, AVG(SalesDollar) AS AvgSales,
  RANK() OVER (ORDER BY AVG(SalesDollar) DESC) AS AvgSalesRank
  FROM SSSales, SSItem, SSTimeDim
  WHERE SSSales.ItemID = SSItem.ItemId AND SSSales.TimeNo = SSTimeDim.TimeNo
    AND TimeYear BETWEEN 2014 and 2015
  GROUP BY ItemBrand;

-- Example 4
-- Rank brands by average sales in 2014 and 2015
-- Only include brands with more than 10 sales in 2014 and 2015
SELECT ItemBrand, AVG(SalesDollar) AS AvgSales, COUNT(*) AS RowCount,
  RANK() OVER (ORDER BY AVG(SalesDollar) DESC) AS AvgSalesRank
  FROM SSSales, SSItem, SSTimeDim
  WHERE SSSales.ItemID = SSItem.ItemId AND SSSales.TimeNo = SSTimeDim.TimeNo
    AND TimeYear BETWEEN 2014 and 2015
  GROUP BY ItemBrand
  HAVING COUNT(*) > 10;