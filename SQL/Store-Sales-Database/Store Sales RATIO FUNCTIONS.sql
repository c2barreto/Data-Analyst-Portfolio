
SET LINESIZE 32000;
SET PAGESIZE 60;

--RATIO FUNCTIONS

-- Example 1
-- Compute contribution ratio on sum of dollar sales by year and customer city with partitioning on year
-- Order result by year and descending sum of sales

SELECT TimeYear, CustCity, SUM(SalesDollar) AS SumSales,
       RATIO_TO_REPORT(SUM(SalesDollar)) 
         OVER (PARTITION BY TimeYear) AS SumSalesRatio 
 FROM SSCustomer, SSSales, SSTimeDim
 WHERE SSSales.CustID = SSCustomer.CustId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
 GROUP BY TimeYear, CustCity
 ORDER BY TimeYear, SUM(SalesDollar) DESC;

-- Example 2
-- Cumulative distribution functions on item unit price
-- Display item name, rank, percent rank, and cumulative distribution

SELECT ItemName, ItemUnitPrice,
  RANK() OVER (ORDER BY ItemUnitPrice) As RankUnitPrice,     
  PERCENT_RANK() 
    OVER (ORDER BY ItemUnitPrice) As PercentRankUnitPrice,
  ROW_NUMBER() 
    OVER (ORDER BY ItemUnitPrice) As RowNumUnitPrice,
  CUME_DIST() 
    OVER (ORDER BY ItemUnitPrice) As CumDistUnitPrice
 FROM SSItem;

-- Example 3
-- Demonstrate treatment of equal values
-- Cumulative distribution functions on sum of sales units by customer name
-- Display customer name, rank, percent rank, and cumulative distribution

SELECT CustName, SUM(SalesUnits) AS SumSalesUnits,
  RANK() OVER (ORDER BY SUM(SalesUnits) ) AS RankSalesUnits,
  PERCENT_RANK() OVER (ORDER BY SUM(SalesUnits) ) 
   AS PerRankSalesUnits,
  ROW_NUMBER() 
    OVER (ORDER BY SUM(SalesUnits)) As RowNumSalesUnits,
  CUME_DIST() OVER (ORDER BY SUM(SalesUnits) ) AS CumDistSalesUnits
 FROM SSSales, SSCustomer
 WHERE SSSales.CUSTID = SSCustomer.CUSTID
 GROUP BY CustName;

-- Example 4
-- Demonstrate top performers

SELECT ItemName, ItemBrand, ItemUnitPrice, CumDistUnitPrice
 FROM ( SELECT ItemId, ItemName, ItemBrand, ItemUnitPrice,
          CUME_DIST() 
  OVER (ORDER BY ItemUnitPrice DESC) As CumDistUnitPrice
  FROM SSItem )
 WHERE CumDistUnitPrice <= 0.3;

-- Example 5
-- Cumulative distribution of dollar sales in Colorado (CO)
-- Remove duplicates
-- Display dollar sales and cumulative distribution

SELECT DISTINCT SalesDollar,
    CUME_DIST() OVER (ORDER BY SalesDollar) 
      As CumDistSalesDollar
FROM SSCustomer, SSSales
WHERE SSCustomer.CustId = SSSales.CustId 
  AND CustState = 'CO'
ORDER BY SalesDollar;

-- Example 6
-- Top performing (30%) store zip codes on sum of dollar sales
-- Partition by year
-- Display year, store city, sum of dollar sales, and cumulative distribution

-- SELECT statement to determine entire distribution
SELECT TimeYear, CustZip, SUM(SalesDollar) AS SumDollarSales,
    CUME_DIST() OVER (PARTITION BY TimeYear ORDER BY SUM(SalesDollar) DESC) As CumDistSalesDollar
 FROM SSCustomer, SSSales, SSTimeDim
 WHERE SSSales.CustID = SSCustomer.CustId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
 GROUP BY TimeYear, CustZip;

-- SELECT statement solution including using the previous statement in the FROM clause
SELECT TimeYear, CustZip, SumDollarSales, CumDistSalesDollar
 FROM ( 
   SELECT TimeYear, Custzip, SUM(SalesDollar) AS SumDollarSales,
       CUME_DIST() OVER (PARTITION BY TimeYear ORDER BY SUM(SalesDollar) DESC) As CumDistSalesDollar
    FROM SSCustomer, SSSales, SSTimeDim
   WHERE SSSales.CustID = SSCustomer.CustId 
     AND SSSales.TimeNo = SSTimeDim.TimeNo
   GROUP BY TimeYear, CustZip )
 WHERE CumDistSalesDollar <= 0.3
 ORDER BY TimeYear, CumDistSalesDollar;


-- Example 7
-- Contribution ratio on sum of 2015 unit sales by month and item brand
-- Partition on month
-- Order result by month and descending sum of unit sales
-- Display month, item brand, number of sales, sum of unit sales, and contribution ratio

SELECT TimeMonth, ItemBrand, SUM(SalesUnits) AS SumUnits,
       RATIO_TO_REPORT(SUM(SalesUnits)) OVER (PARTITION BY TimeMonth) AS SumUnitsRatio 
 FROM SSItem, SSSales, SSTimeDim
 WHERE SSSales.ItemID = SSitem.ItemId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND TimeYear = 2015
 GROUP BY TimeMonth, ItemBrand
 ORDER BY TimeMonth, SUM(SalesUnits) DESC;

-- Example 8
-- Contribution ratio on sum of 2015 unit sales by item brand
-- No partitioning
-- Order result by descending sum of unit sales
-- Display item brand, number of sales, sum of unit sales, and contribution ratio

SELECT ItemBrand, SUM(SalesUnits) AS SumBrandUnits,
       RATIO_TO_REPORT(SUM(SalesUnits)) OVER () AS SumBrandUnitRatio 
 FROM SSItem, SSSales, SSTimeDim
 WHERE SSSales.ItemID = SSitem.ItemId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo AND TimeYear = 2015
 GROUP BY ItemBrand
 ORDER BY SUM(SalesUnits) DESC;
