WITH Sales1997 AS (
    SELECT 
        o.EmployeeID,
        ROUND(SUM(CONVERT(od.Quantity, DECIMAL(9, 2)) * CONVERT(p.Price, DECIMAL(9, 2))), 2) AS TotalSales1997
    FROM 
        orders AS o
    LEFT JOIN 
        orderdetails AS od ON CONVERT(o.OrderID, UNSIGNED) = CONVERT(od.OrderID, UNSIGNED)
    LEFT JOIN 
        products AS p ON CONVERT(od.ProductID, UNSIGNED) = CONVERT(p.ProductID, UNSIGNED)
    WHERE 
        YEAR(STR_TO_DATE(o.OrderDate, '%m/%d/%Y')) = 1997
    GROUP BY 
        o.EmployeeID
),
PreviousSales AS (
    SELECT 
        o.EmployeeID,
        ROUND(SUM(CONVERT(od.Quantity, DECIMAL(9, 2)) * CONVERT(p.Price, DECIMAL(9, 2))), 2) AS TotalSalesPrevious
    FROM 
        orders AS o
    LEFT JOIN 
        orderdetails AS od ON CONVERT(o.OrderID, UNSIGNED) = CONVERT(od.OrderID, UNSIGNED)
    LEFT JOIN 
        products AS p ON CONVERT(od.ProductID, UNSIGNED) = CONVERT(p.ProductID, UNSIGNED)
    WHERE 
        STR_TO_DATE(o.OrderDate, '%m/%d/%Y') < '1997-01-01'
    GROUP BY 
        o.EmployeeID
)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s97.TotalSales1997 AS TotalSales1997,
    ps.TotalSalesPrevious AS TotalSalesPrevious,
    s97.TotalSales1997 - ps.TotalSalesPrevious AS SalesGrowth
FROM 
    employees AS e
LEFT JOIN 
    Sales1997 AS s97 ON CONVERT(e.EmployeeID, UNSIGNED) = CONVERT(s97.EmployeeID, UNSIGNED)
LEFT JOIN 
    PreviousSales AS ps ON CONVERT(e.EmployeeID, UNSIGNED) = CONVERT(ps.EmployeeID, UNSIGNED)
ORDER BY 
    SalesGrowth DESC
LIMIT 3;