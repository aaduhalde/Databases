/*
Transact-SQL permiten almacenar temporalmente valores en variables, aplicar la ejecuci�n condicional de comandos,
pasar par�metros a procedimientos almacenados y controlar el flujo de los programas.

IF...ELSE: instrucci�n condicional que permite decidir qu� aspectos del c�digo se ejecutar�n.
WHILE: instrucci�n de bucle que es ideal para ejecutar iteraciones de instrucciones T-SQL.
DECLARE: lo usar� para definir variables.
SET: una de las maneras en las que asignar� valores a las variables.
BATCHES: serie de instrucciones T-SQL que se ejecutan como una unidad.

--LOTES
INSERT INTO dbo.t1 VALUES(1,2,N'abc');
INSERT INTO dbo.t1 VALUES(2,3,N'def');
GO

--Declare and initialize the variables.
DECLARE @numrows INT = 3, @catid INT = 2;
--Use variables to pass the parameters to the procedure.
EXEC Production.ProdsByCategory @numrows = @numrows, @catid = @catid;
GO

--En el ejemplo siguiente se muestran las tres maneras de declarar y asignar valores a variables:
DECLARE @var1 AS INT = 99;
DECLARE @var2 AS NVARCHAR(255);
SET @var2 = N'string';
DECLARE @var3 AS NVARCHAR(20);
SELECT @var3 = lastname FROM HR.Employees WHERE empid=1;
SELECT @var1 AS var1, @var2 AS var2, @var3 AS var3;
GO

--Trabajo con sinonimos
/*sinonimos proporcionan un m�todo para crear un v�nculo, o alias, 
a un objeto almacenado en la misma base de datos o incluso en otra instancia de SQL Server. 
Los objetos que pueden tener sin�nimos definidos para ellos 
incluyen tablas, vistas, procedimientos almacenados y funciones definidas por el usuario.

Los sin�nimos se pueden usar para que un objeto remoto parezca local 
o para proporcionar un nombre alternativo para un objeto local.
*/
CREATE SYNONYM dbo.ProdsByCategory FOR TSQL.Production.ProdsByCategory;
GO
EXEC dbo.ProdsByCategory @numrows = 3, @catid = 2;
/*
Para crear un sinonimo, debe tener el permiso "CREATE SYNONYM",
asi como el permiso para modificar el esquema en el que se almacenar� el sin�nimo.
*/

--function:
--DENTRO DEL SELECT una COLUMNA LEVEL
CASE
	WHEN (SUM(od.Quantity * od.UnitPrice) >= 30000) THEN 'A'
	WHEN (SUM(od.Quantity * od.UnitPrice) < 30000 AND SUM(od.Quantity * od.UnitPrice) >= 20000) THEN 'B'
	ELSE 'C'
	END AS LEVEL

--Joins
USE Northwind
GO
SELECT TOP 10 p.ProductName, sum(od.Quantity) AS [Units Sold]
FROM [Order Details] od
INNER JOIN [Products] p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER By [Units Sold] DESC
*/

--encuentre el producto que tiene el precio mas alta en la compania.
USE Northwind
GO
SELECT ProductID, ProductName, UnitPrice
FROM [Products]
ORDER BY UnitPrice DESC

--(n-1)
-- 2-1 = 1 posicion 2
-- 3-1 = 2 posicion 3
-- 1-1 = 0 posicion 1

USE Northwind
GO
SELECT ProductName, UnitPrice
FROM [Products] p1
WHERE 1 = (SELECT count(DISTINCT UnitPrice)
			FROM Products p2
			WHERE p2.UnitPrice > p1.UnitPrice)

--RANK producto mas vendidos ordenados por ciudad,
USE Northwind
GO
SELECT p.ProductName, c.City, od.Quantity,
DENSE_RANK () OVER (PARTITION BY c.City ORDER BY od.quantity DESC) AS RANK
--PARTICION POR CIUDAD
FROM [Customers] c
INNER JOIN [Orders] o on (c.CustomerID = o.CustomerID)
INNER JOIN [Order Details] od on (o.OrderID = od.OrderID)
INNER JOIN [Products] p on (od.ProductID = p.ProductID)
WHERE Country = 'USA'
--ORDER BY od.Quantity DESC
--and city
ORDER BY RANK ASC

--Encontrar las ordenes que tardamos mas de dos dias de entregar, 
--Donde el valor sea mayor de diez mil.
USE Northwind
GO
SELECT o.OrderID, o.CustomerID, o.OrderDate, o.ShippedDate, o.ShipCountry,
--diferencias por dias
DATEDIFF (DAY, OrderDate, ShippedDate) AS [Duration_To_Ship],
SUM(od.Quantity * od.UnitPrice) as [Total Sale Amount]
FROM [Orders] o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE DATEDIFF (DAY, OrderDAte, ShippedDAte) > 2
GROUP BY o.OrderID, o.CustomerID, o.OrderDate, o.ShippedDate, o.ShipCountry
HAVING SUM(od.Quantity * od.UnitPrice) > 10000
ORDER BY [Duration_To_Ship] asc



--Econtrar el top 10 de clientes mas valiosos,
USE Northwind
GO
SELECT TOP 10 c.CompanyName, c.Country, c.City,
SUM(od.Quantity * od.UnitPrice) as [Total Sale]
FROM [Customers] c
INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = '2018'
GROUP BY c.CompanyName, c.Country, c.City
ORDER BY [Total Sale] DESC



--los productos de venta mayor igual a 30 mil y las unidades que se vendieron
--en el a�o 2018
USE Northwind
GO
SELECT p.ProductName, sum(od.Quantity) as [Number of unites], sum(od.Quantity*od.UnitPrice) as [Total sale Amount]
FROM [Orders] o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN [Products] p ON od.ProductID = p.ProductID
WHERE YEAR(o.OrderDate) = '2018'
GROUP BY p.ProductName
HAVING sum(od.Quantity*od.UnitPrice) >= 30000



--Clasificacion de los clientes por total de ventas
-- >= 30000 NIVEL A
-- <= 20000 NIVEL B
-- <  20000	NIVEL C

USE Northwind
GO
SELECT c.CompanyName,
SUM(od.Quantity * od.UnitPrice) AS TOTAL,
--DENTRO DEL SELECT una COLUMNA LEVEL
CASE
	WHEN (SUM(od.Quantity * od.UnitPrice) >= 30000) THEN 'A'
	WHEN (SUM(od.Quantity * od.UnitPrice) < 30000 AND SUM(od.Quantity * od.UnitPrice) >= 20000) THEN 'B'
	ELSE 'C'
	END AS LEVEL

FROM [Customers] c
INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName

/*

CASE
	WHEN (SUM(od.Quantity * od.UnitPrice) >= 30000) THEN 'A'
	WHEN (SUM(od.Quantity * od.UnitPrice) < 30000 AND SUM(od.Quantity * od.UnitPrice) >= 20000) THEN 'B'
	ELSE 'C'
	END AS LEVEL

*/



-- Que clientes generaron ventas por arriba del promedio del total
-- de ventas? filtrar por dato.
USE Northwind
GO
SELECT c.CompanyName, c.City, c.Country,
SUM(od.Quantity * od.UnitPrice) AS TOTAL
FROM [Customers] c
INNER JOIN [Orders] o ON (c.CustomerID = o.CustomerID)
iNNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR (o.OrderDate) = '2018'
GROUP BY c.CompanyName, c.City, c.Country
HAVING SUM(od.Quantity * od.UnitPrice) > (SELECT AVG(Quantity * UnitPrice) FROM [Order Details])
ORDER BY TOTAL DESC

--�Que clientes no han comprado en los ultimos 20 meses?
USE Northwind
GO
SELECT c.CompanyName, MAX(o.OrderDate),
DATEDIFF(MONTH, MAX(o.OrderDate), GETDATE()) AS [Months_Since_Last_Order]
FROM [Customers] c
INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
HAVING DATEDIFF(MONTH, MAX(o.OrderDate), GETDATE()) > 20

--Numero de Ordenes por cliente.
USE Northwind
GO
SELECT c.CompanyName,
 (SELECT COUNT(OrderID) FROM [Orders] o
 WHERE c.CustomerID = o.CustomerID ) AS [number od orders]
FROM [Customers] c
ORDER BY [number od orders] DESC

--Duracion de dias entre ordenes de cada cliente
USE Northwind
GO
SELECT a.CustomerID, a.OrderDate, b.OrderDate,
DATEDIFF(DAY, a.OrderDate, b.OrderDate) as [Days betwenn two orders]
FROM [Orders] a
INNER JOIN [Orders] b ON a.OrderID = b.OrderID - 1

--Calcula los empleados con mas ventas 
--Calcula un bono
USE Northwind
GO
SELECT TOP 3 e.FirstName + ' ' + e.LastName AS [Full Name],
SUM(od.Quantity * od.UnitPrice) as [Total Sale],
ROUND(SUM(od.Quantity * od.UnitPrice)*0.02,0) as BONUS
FROM [Employees] e
INNER JOIN [Orders] o ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = '2018'
AND MONTH(o.OrderDate) = '1'
GROUP BY  e.FirstName + ' ' + e.LastName

--Cuanto empleados tenemos por posicion y por ciudad
USE Northwind
GO
SELECT title, city, region, count(EmployeeID)
FROM [Employees]
GROUP BY title, city, region

--�Cuanto tiempo llevan trabajando tus empleados?
USE Northwind
GO
SELECT LastName, FirstName, Title,
DATEDIFF(YEAR, HireDate, GETDATE()) AS [Work years in the company]
FROM [Employees]

--�cuantos empleados son mayores de 70 a�os
USE Northwind
GO
SELECT FirstName, LastName, Title,
DATEDIFF(YEAR, BirthDate, GETDATE()) AS AGE
FROM [Employees]
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) >= 70




