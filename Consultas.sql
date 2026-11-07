USE AdventureWorksDW2025;
GO

SELECT
    YEAR(OrderDate) AS Anio,
    SUM(SalesAmount) AS TotalVentas
FROM dbo.FactInternetSales
GROUP BY YEAR(OrderDate)
ORDER BY Anio;
GO

USE AdventureWorksDW2025;
GO

SELECT
    PC.EnglishProductCategoryName AS Categoria,
    SUM(FIS.SalesAmount) AS TotalVentas
FROM dbo.FactInternetSales FIS
INNER JOIN dbo.DimProduct DP
    ON FIS.ProductKey = DP.ProductKey
INNER JOIN dbo.DimProductSubcategory PS
    ON DP.ProductSubcategoryKey = PS.ProductSubcategoryKey
INNER JOIN dbo.DimProductCategory PC
    ON PS.ProductCategoryKey = PC.ProductCategoryKey
GROUP BY PC.EnglishProductCategoryName
ORDER BY TotalVentas DESC;
GO

-------------
SELECT TOP 10
    DP.EnglishProductName AS Producto,
    SUM(FIS.SalesAmount) AS TotalVentas
FROM dbo.FactInternetSales FIS
INNER JOIN dbo.DimProduct DP
    ON FIS.ProductKey = DP.ProductKey
GROUP BY DP.EnglishProductName
ORDER BY TotalVentas DESC;
GO
-----Ventas por territorio
SELECT
    ST.SalesTerritoryRegion AS Territorio,
    ST.SalesTerritoryCountry AS Pais,
    SUM(FIS.SalesAmount) AS TotalVentas
FROM dbo.FactInternetSales FIS
INNER JOIN dbo.DimSalesTerritory ST
    ON FIS.SalesTerritoryKey = ST.SalesTerritoryKey
GROUP BY
    ST.SalesTerritoryRegion,
    ST.SalesTerritoryCountry
ORDER BY TotalVentas DESC;
GO

-------------clientes con mayor compra

SELECT TOP 10
    C.FirstName + ' ' + C.LastName AS Cliente,
    SUM(F.SalesAmount) AS TotalCompras
FROM dbo.FactInternetSales F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerKey = C.CustomerKey
GROUP BY
    C.FirstName,
    C.LastName
ORDER BY TotalCompras DESC;
GO

---------comparacion de ventas 

SELECT
    YEAR(OrderDate) AS Anio,
    SUM(SalesAmount) AS TotalVentas,
    SUM(TotalProductCost) AS TotalCostos,
    SUM(SalesAmount - TotalProductCost) AS Utilidad
FROM dbo.FactInternetSales
GROUP BY YEAR(OrderDate)
ORDER BY Anio;
GO