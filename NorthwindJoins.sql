SELECT
    od.Quantity
,od.UnitPrice
,od.quantity 
,od.UnitPrice * od.Quantity AS LineTotal
,o.OrderDate
,c.CompanyName
,c.ContactName
,p.ProductName
,cat.CategoryName
FROM
    [Order Details] od
    LEFT JOIN Orders o ON od.OrderID = o.OrderID
    LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
    LEFT JOIN Products p ON od.ProductID = p.ProductID
    LEFT JOIN Categories cat ON p.CategoryID = cat.CategoryID