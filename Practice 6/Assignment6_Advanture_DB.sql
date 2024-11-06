--Part 2:

use AdventureWorks2012
--1.	Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) to designate SalesOrders that occurred within the period 	
SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE ShipDate BETWEEN '2005-06-01' AND '2005-12-31';

 
--2.	Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
SELECT ProductID, Name
FROM Production.Product
WHERE StandardCost < 110.00;

--3.	Display ProductID, Name if its weight is unknown
SELECT ProductID, Name
FROM Production.Product
WHERE Weight IS NULL;

--4.	 Display all Products with a Silver, Black, or Red Color
SELECT ProductID, Name
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red');

--5.	 Display any Product with a Name starting with the letter B
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'B%';

--6. Run the following Query
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3
--Then write a query that displays any Product description with underscore value in its description.*/
SELECT Description
FROM Production.ProductDescription
WHERE Description LIKE '%_%'
AND ProductDescriptionID = 3;


--7.	 Display the Employees HireDate (note no repeated values are allowed)
SELECT DISTINCT HireDate
FROM HumanResources.Employee;

--8.	Display the Product Name and its ListPrice within the values of 100 and 120 the list should have the following format "The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value)
SELECT concat ('The ', Name, ' is only! ' ,CAST(ListPrice AS VARCHAR)) AS [Product Info]
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice;