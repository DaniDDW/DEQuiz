/* Count distinct new customers in 1997 */
SELECT COUNT(DISTINCT CustomerID) AS new_customers_1997
FROM (
    SELECT CustomerID, MIN(STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS first_order_date
    FROM orders
    GROUP BY CustomerID
) AS first_order
WHERE YEAR(first_order_date) = 1997;

/* Details of distinct new customers in 1997 */
SELECT DISTINCT c.CustomerID, c.CustomerName, fo.first_order_date
FROM (
    SELECT CustomerID, MIN(STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS first_order_date
    FROM orders
    GROUP BY CustomerID
) AS fo
LEFT JOIN customers AS c ON fo.CustomerID = c.CustomerID
WHERE YEAR(first_order_date) = 1997;