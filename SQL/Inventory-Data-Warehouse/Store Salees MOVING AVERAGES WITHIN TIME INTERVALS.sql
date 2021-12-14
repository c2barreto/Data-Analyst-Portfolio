SET LINESIZE 32000;
SET PAGESIZE 60;

-- Moving Averages and Time Windows
-- Example 1
-- Moving average of sum of sales by zip and year, and month. Center with previous and next row

SELECT StoreZip, TimeYear, SUM(SalesDollar) AS SumSales,
  AVG(SUM(SalesDollar)) OVER 
   (ORDER BY StoreZip, TimeYear
   ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS CenterMovAvgSumSales
 FROM SSStore, SSTimeDim, SSSales
 WHERE SSSales.StoreID = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
 GROUP BY StoreZip, TimeYear;

-- Example 2
-- Moving average of sum of sales by zip, year, and month. Center with previous and next rows

SELECT TimeYear, SUM(SalesDollar) AS SumSales,
  AVG(SUM(SalesDollar)) OVER 
   (ORDER BY TimeYear
   RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS CenterMovAvgSumSales
 FROM SSStore, SSTimeDim, SSSales
 WHERE SSSales.StoreID = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
 GROUP BY TimeYear;

-- Example 3
-- Moving average of sum of 2010 sales by item brand and year
-- Centered window on 2 preceding and 2 following rows
-- Only include brands with more than 5 sales per year
-- Show item brand, year, count, and sum of sales in the result

SELECT TimeYear, ItemBrand, COUNT(*) AS RowCount, SUM(SalesDollar) AS SumSales,
  AVG(SUM(SalesDollar)) OVER (PARTITION BY TimeYear
    ORDER BY ItemBrand, TimeYear
    ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING ) AS SlidingAvgSumSales
  FROM SSSales, SSItem, SSTimeDim
  WHERE SSSales.ItemID = SSItem.ItemId AND SSSales.TimeNo = SSTimeDim.TimeNo
  GROUP BY TimeYear, ItemBrand
  HAVING COUNT(*) > 5 ;

-- Example 4
-- Moving average of sum of 2010 sales by month
-- Centered window on 3 preceding and 3 following months
-- Show month, sum of sales, and moving average of sum of sales

SELECT TimeMonth, SUM(SalesDollar) AS SumSales,
  AVG(SUM(SalesDollar)) OVER 
   (ORDER BY TimeMonth
   RANGE BETWEEN 3 PRECEDING AND 3 FOLLOWING) AS CenterMovAvgSumSales
 FROM SSStore, SSTimeDim, SSSales
 WHERE SSSales.StoreID = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND TimeYear = 2010
 GROUP BY TimeMonth;

-- Example 5
-- Moving average of sum of sales by store zip and sales date
-- Partition by store zip
-- Centered window on 3 previous months and 3 next months
-- Only include brands with more than 5 sales in a year
-- Show store zip, sales date, sum of sales, and average sum of sales

SELECT StoreZip, 
       to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  
               to_char(TimeYear), 'DDMMYYYY') AS TimeDimDate,
       SUM(SalesDollar) AS SumSales,
       AVG(SUM(SalesDollar)) OVER ( PARTITION BY StoreZip 
       ORDER BY to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear), 'DDMMYYYY')
       RANGE BETWEEN INTERVAL '3' MONTH PRECEDING AND INTERVAL '3' MONTH FOLLOWING) AS CenterMovAvgSumSales
 FROM SSStore, SSTimeDim, SSSales
 WHERE SSSales.StoreID = SSStore.StoreId AND SSSales.TimeNo = SSTimeDim.TimeNo
 GROUP BY StoreZip, to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  
                            to_char(TimeYear), 'DDMMYYYY'); 

-- Here statements that demonstrate generating date components into a complete date.
-- to_char by itself

SELECT TimeNo, TimeDay, TimeMonth, TimeYear,
       to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear) AS TimeDimDate
FROM SSTimeDim;


-- to_date with to_char

SELECT TimeNo, TimeDay, TimeMonth, TimeYear,
       to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear), 'DDMMYYYY') AS TimeDimDate
FROM SSTimeDim;


-- Other window variations for years and days
-- Using year units with INTERVAL keyword

SELECT StoreZip, 
       to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear), 'DDMMYYYY') AS TimeDimDate,
       SUM(SalesDollar) AS SumSales,
       AVG(SUM(SalesDollar)) OVER 
      (ORDER BY to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear), 'DDMMYYYY')
       RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND INTERVAL '1' YEAR FOLLOWING) AS CenterMovAvgSumSales
FROM SSStore, SSTimeDim, SSSales
WHERE SSSales.StoreID = SSStore.StoreId AND SSSales.TimeNo = SSTimeDim.TimeNo
GROUP BY StoreZip, to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear), 'DDMMYYYY'); 


-- Using default day units without explicit intervals

SELECT StoreZip, 
       to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear), 'DDMMYYYY') AS TimeDimDate,
       SUM(SalesDollar) AS SumSales,
       AVG(SUM(SalesDollar)) OVER 
      (ORDER BY to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear), 'DDMMYYYY')
       RANGE BETWEEN '365' PRECEDING AND '365' FOLLOWING) AS CenterMovAvgSumSales
FROM SSStore, SSTimeDim, SSSales
WHERE SSSales.StoreID = SSStore.StoreId AND SSSales.TimeNo = SSTimeDim.TimeNo
GROUP BY StoreZip, to_date(to_char(TimeDay,'FM00') || to_char(TimeMonth,'FM00') ||  to_char(TimeYear), 'DDMMYYYY'); 

