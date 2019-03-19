-- get all stores
SELECT Stores.Store_ID, Stores.Store_Phone_Number, Stores.Store_Address_Street, Stores.Store_Address_Zip FROM Stores
-- get one store matches store_id
SELECT Store_ID, Store_Phone_Number, Store_Address_Street, Store_Address_Zip FROM Stores WHERE Store_ID =?
-- update store that matches store_id
UPDATE Stores SET Store_Phone_Number=?,Store_Address_Street=?,Store_Address_Zip=? WHERE Store_ID =?
-- add to store table
insert into Stores (Store_Phone_Number, Store_Address_Street, Store_Address_Zip) values (?,?,?)

-- get all service plans
SELECT ServicePlans.Plan_ID, ServicePlans.Plan_Name, ServicePlans.Plan_Cost, ServicePlans.Plan_Desc from ServicePlans
-- get sincle service plan that matches plan_id
SELECT Plan_ID, Plan_Cost, Plan_Name, Plan_Desc FROM ServicePlans WHERE Plan_ID = ?
-- update service plan that matches the plan_id
UPDATE ServicePlans SET Plan_Cost=?,Plan_Name=?,Plan_Desc=? WHERE Plan_ID =?
-- add to plans table
INSERT INTO ServicePlans(Plan_Name, Plan_Cost,  Plan_Desc) VALUES (?,?,?)

-- get all phone info
SELECT Phones_Infos.SKU, Phones_Infos.Manufacturer, Phones_Infos.Model, Phones_Infos.Phone_Name, Phones_Infos.Phone_Price FROM Phones_Infos order by Phones_Infos.Manufacturer asc
-- get one phone that matches SKU
SELECT SKU, Manufacturer, Model, Phone_Name, Phone_Price FROM Phones_Infos WHERE SKU = ?
-- update phone that matches SKU
UPDATE Phones_Infos SET Manufacturer=?,Model=?,Phone_Name=?,Phone_Price=? WHERE SKU =?
-- add to phones table
INSERT INTO Phones_Infos (SKU, Manufacturer, Model, Phone_Name, Phone_Price) VALUES (?,?,?,?,?)
-- delete a phone that matches sku
DELETE FROM Phones_Infos WHERE SKU = ?

-- view all orders
SELECT Orders.Order_ID, Customers.Cust_Name, Orders.Order_Date FROM Orders LEFT JOIN Customers ON Orders.Cust_ID = Customers.Cust_ID
-- view order info matching a cust_ID
select Orders.Order_ID, Orders.Order_Date, Employees.Emp_Name, Phones_Infos.Phone_Name, ServicePlans.Plan_Name , Phones_Infos.Phone_Price from Orders inner join Employees on Employees.Emp_ID = Orders.Emp_ID inner join Phones on Phones.IMEI = Orders.IMEI inner join Phones_Infos on Phones_Infos.SKU = Phones.SKU inner join ServicePlans on Orders.Plan_ID = ServicePlans.Plan_ID where Cust_ID = ?
-- add to orders table
insert into Orders (Cust_ID, Emp_ID, Order_Date, Plan_ID, IMEI) values (?,?,?,?,?)
-- supplementally add imei and sku to phones table when adding new order
insert into Phones (IMEI, SKU) values (?,?)

-- view all customers
SELECT Cust_ID, Customers.Cust_Name, Customers.Cust_Email, Customers.Cust_Phone_Number, Customers.Cust_Address_Street, Customers.Cust_Address_Zip FROM Customers
-- get one customer that matches Cust_ID
Select Cust_ID, Cust_Name, Cust_Email, Cust_Phone_Number, Cust_Address_Street, Cust_Address_Zip from Customers where Cust_ID = ?
-- get employee ids for select field to add new order
select Emp_ID as id, Emp_Name as name from Employees
-- get phone sku and name for select field to add new order
select SKU, Phone_Name from Phones_Infos
-- get plan id and plan name for select field to add to new order
select Plan_ID as planid, Plan_Name as planName from ServicePlans
-- search for customers
SELECT * FROM Customers WHERE
		Cust_Name=? AND 
		Cust_Email=? AND
		Cust_Phone_Number=? AND 
		Cust_Address_Street=? AND 
		Cust_Address_Zip=? AND
-- update customers matching Cust_ID
UPDATE Customers SET Cust_Name=?,Cust_Email=?,Cust_Phone_Number=?,Cust_Address_Street=?,Cust_Address_Zip=? WHERE Cust_ID = ?

-- get all employees
SELECT Employees.Emp_ID, Employees.Emp_Name, Employees.Store_ID, Employees.Emp_Phone_Number, Employees.Emp_Address_Street, Employees.Emp_Address_Zip FROM Employees
-- get single employee matching emp_id
SELECT Emp_ID, Emp_Name, Store_ID, Emp_Phone_Number, Emp_Address_Street, Emp_Address_Zip FROM Employees WHERE Emp_ID = ?
-- search for employee
SELECT * FROM Employees WHERE
		Emp_Name=? AND
		Store_ID=? AND
		Emp_Phone_Number=? AND
		Emp_Address_Street=? AND
		Emp_Address_Zip=? AND
-- get store id for select field to add new employee
select Store_ID as id from Stores
-- update employee matching emp_id
UPDATE Employees SET Emp_Name=?,Store_ID=?,Emp_Phone_Number=?,Emp_Address_Street=?,Emp_Address_Zip=? WHERE Emp_ID = ?
-- add to employee table
insert into Employees (Emp_Name, Store_ID, Emp_Phone_Number, Emp_Address_Street, Emp_Address_Zip) values (?,?,?,?,?)