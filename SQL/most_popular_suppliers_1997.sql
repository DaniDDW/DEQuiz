SELECT CONVERT(s.SupplierID, UNSIGNED) AS SupplierID, s.SupplierName, SUM(CONVERT(od.Quantity, UNSIGNED)) AS TotalProductsSold
FROM suppliers AS s
LEFT JOIN products AS p ON CONVERT(s.SupplierID, UNSIGNED) = CONVERT(p.SupplierID, UNSIGNED)
LEFT JOIN orderdetails AS od ON CONVERT(p.ProductID, UNSIGNED) = CONVERT(od.ProductID, UNSIGNED)
LEFT JOIN orders AS o ON CONVERT(od.OrderID, UNSIGNED) = CONVERT(o.OrderID, UNSIGNED)
WHERE YEAR(STR_TO_DATE(o.OrderDate, '%m/%d/%Y')) = 1997
GROUP BY s.SupplierID, s.SupplierName
ORDER BY TotalProductsSold DESC
LIMIT 5;