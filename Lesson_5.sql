/*
Задание 1: Создание таблицы и изменение данных
Задание: Создайте таблицу EmployeeDetails для хранения информации о
сотрудниках. Таблица должна содержать следующие столбцы:
	● EmployeeID (INTEGER, PRIMARY KEY)
	● EmployeeName (TEXT)
	● Position (TEXT)
	● HireDate (DATE)
	● Salary (NUMERIC)
После создания таблицы добавьте в неё три записи с произвольными данными о
сотрудниках.
*/

-- Создание таблицы
CREATE TABLE EmployeeDetails (
	EmployeeID INTEGER PRIMARY KEY,
	EmployeeName TEXT,
	Position TEXT,
	HireDate DATE,
	Salary NUMERIC
);

-- Добавление данных
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary) VALUES (1, 'John Smith', 'Sales Manager', '2022-01-15', 55000);
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary) VALUES (2, 'Jane Doe', 'Marketing Specialist', '2021-06-30', 48000);
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary) VALUES (3, 'Emily Johnson', 'Software Engineer', '2023-03-22', 65000);

SELECT * FROM EmployeeDetails
-------------------------------------------------------------------------------------

/*
Задание 2: Создание представления
Задание: Создайте представление HighValueOrders для отображения всех заказов,
сумма которых превышает 10000. В представлении должны быть следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● TotalAmount (общая сумма заказа, вычисленная как сумма всех Quantity *
Price).
Используйте таблицы Orders, OrderDetails и Products.
*/

CREATE VIEW HighValueOrders AS
SELECT
	o.OrderID,
	o.OrderDate,
	SUM(od.Quantity * p.Price) AS TotalAmount
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID, o.OrderDate
HAVING SUM(od.Quantity * p.Price) > 10000;
-------------------------------------------------------------------------------------

/*
Задание 3: Удаление данных и таблиц
Задание: Удалите все записи из таблицы EmployeeDetails, где Salary меньше
50000. Затем удалите таблицу EmployeeDetails из базы данных.
*/

-- Удаление данных
DELETE FROM EmployeeDetails WHERE Salary < 50000;

-- Удаление таблицы
DROP TABLE EmployeeDetails;
-------------------------------------------------------------------------------------

/*
Задание 4: Создание хранимой процедуры
Задание: Создайте хранимую процедуру GetProductSales с одним параметром
ProductID. Эта процедура должна возвращать список всех заказов, в которых
участвует продукт с заданным ProductID, включая следующие столбцы:
	● OrderID (идентификатор заказа),
	● OrderDate (дата заказа),
	● CustomerID (идентификатор клиента).
*/

-- В SQLITE создание хранимых процедур невозможно
-- Код ниже работает в MS SQL

CREATE PROCEDURE GetProductSales
	@p_ProductID INTEGER
    AS
	BEGIN
		SELECT
			o.OrderID,
			o.OrderDate,
			o.CustomerID
		FROM Orders o
		JOIN OrderDetails od ON o.OrderID = od.OrderID
		WHERE od.ProductID = @p_ProductID;
	END;
	--------------------------------------------------------------------------



