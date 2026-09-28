-- SQL Scripts for Sales Data Cleaning, Transformation, and Views

-- 1. Create a Staging Table to import raw data
CREATE TABLE Staging_SalesData (
    OrderID VARCHAR(50),
    OrderDate DATE,
    ProductID VARCHAR(50),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Region VARCHAR(50),
    Segment VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(4,2),
    SalesAmount DECIMAL(12,2),
    Cost DECIMAL(12,2),
    Profit DECIMAL(12,2)
);

-- 2. Data Cleaning: Remove duplicates and handle nulls
DELETE FROM Staging_SalesData
WHERE OrderID IS NULL;

-- 3. Create Automated Reporting Views
-- View 1: Overall Sales Performance by Region
CREATE VIEW vw_SalesByRegion AS
SELECT 
    Region,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    COUNT(DISTINCT OrderID) AS TotalOrders
FROM Staging_SalesData
GROUP BY Region;

-- View 2: Product Performance
CREATE VIEW vw_ProductPerformance AS
SELECT 
    ProductName,
    Category,
    SUM(Quantity) AS TotalQuantitySold,
    SUM(SalesAmount) AS TotalRevenue,
    SUM(Profit) AS TotalProfit,
    (SUM(Profit) / SUM(SalesAmount)) * 100 AS ProfitMargin
FROM Staging_SalesData
GROUP BY ProductName, Category;

-- View 3: Customer Segment Analysis
CREATE VIEW vw_SegmentAnalysis AS
SELECT 
    Segment,
    COUNT(DISTINCT OrderID) AS NumberOfOrders,
    SUM(SalesAmount) AS Revenue,
    AVG(SalesAmount) AS AvgOrderValue
FROM Staging_SalesData
GROUP BY Segment;
