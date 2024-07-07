/* Count distinct return customers in 1997 */
SELECT COUNT(DISTINCT o1.CustomerID) AS return_customers_1997
FROM orders AS o1
WHERE YEAR(STR_TO_DATE(o1.OrderDate, '%m/%d/%Y')) = 1997
AND EXISTS (
    SELECT 1
    FROM orders AS o2
    WHERE o2.CustomerID = o1.CustomerID
    AND STR_TO_DATE(o2.OrderDate, '%m/%d/%Y') < STR_TO_DATE(o1.OrderDate, '%m/%d/%Y')
    AND DATEDIFF(STR_TO_DATE(o1.OrderDate, '%m/%d/%Y'), STR_TO_DATE(o2.OrderDate, '%m/%d/%Y')) > 90);

/* Details of distinct return customers in 1997 */
SELECT o1.CustomerID, c.CustomerName, MIN(o1.OrderDate) AS return_customers_1997
FROM orders AS o1
LEFT JOIN customers AS c ON c.CustomerID = o1.CustomerID
WHERE YEAR(STR_TO_DATE(o1.OrderDate, '%m/%d/%Y')) = 1997
AND EXISTS (
    SELECT 1
    FROM orders AS o2
    WHERE o2.CustomerID = o1.CustomerID
    AND STR_TO_DATE(o2.OrderDate, '%m/%d/%Y') < STR_TO_DATE(o1.OrderDate, '%m/%d/%Y')
    AND DATEDIFF(STR_TO_DATE(o1.OrderDate, '%m/%d/%Y'), STR_TO_DATE(o2.OrderDate, '%m/%d/%Y')) > 90)
GROUP BY o1.CustomerID, c.CustomerName
ORDER BY o1.CustomerID;