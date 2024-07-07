SELECT pc.CategoryName,ROUND(SUM(CONVERT(od.Quantity, DECIMAL(9,2)) * CONVERT(p.Price, DECIMAL(9,2))), 2) AS SalesAmount
FROM products AS p
LEFT JOIN orderdetails AS od ON CONVERT(p.ProductID, UNSIGNED) = CONVERT(od.ProductID, UNSIGNED)
LEFT JOIN orders AS o ON CONVERT(od.OrderID, UNSIGNED) = CONVERT(o.OrderID, UNSIGNED)
LEFT JOIN categories AS pc ON CONVERT(p.CategoryID, UNSIGNED) = CONVERT(pc.CategoryID, UNSIGNED)
WHERE YEAR(STR_TO_DATE(o.OrderDate, '%m/%d/%Y')) = 1997
GROUP BY pc.CategoryName
ORDER BY SalesAmount DESC;