-- /////////////
-- what to select from stores?

-- 1. Select all info for all stores
		-- Used to list the stores in the manage page
SELECT * FROM Stores;

-- 2. 

-- /////////////
-- what to select from customers?
-- 1. Customer lookup, would only need to look up their phone number and verify the name matches
SELECT Cust_Name, Cust_Phone_Number FROM Customers 
WHERE Cust_Name=:Cust_Name_Search 
OR Cust_Phone_Number=:Cust_Phone_Search 
OR Cust_Email=:Cust_Email_Search;

-- 2. Show customer name, their service plan information(s)
-- add WHERE clause to filter
SELECT c.Cust_Name, sp.Plan_Name, sp.Plan_Desc, sp.Plan_Cost FROM Customers c
inner join Orders o on o.Cust_ID = c.Cust_ID
inner join Orders_Products op on op.Order_ID = o.Order_ID
inner join ServicePlans sp on op.Plan_ID = sp.Plan_ID;

-- 3. Show customer name, their phone information(s)
-- add WHERE clause to filter
SELECT c.Cust_Name, pi.Manufacturer, pi.Phone_Name FROM Customers c
inner join Orders o on o.Cust_ID = c.Cust_ID
inner join Orders_Products op on op.Order_ID = o.Order_ID
inner join Phones p on op.IMEI = p.IMEI
inner join Phones_Infos pi on p.SKU = pi.SKU;


-- 4. Show customer name, when they made that order, and what they purchased
-- add WHERE clause to filter
select c.Cust_Name, o.Order_ID, o.Order_Date, sp.Plan_Name, pi.Phone_Name from Customers c
inner join Orders o on o.Cust_ID = c.Cust_ID
inner join Orders_Products op on op.Order_ID = o.Order_ID
inner join Phones p on op.IMEI = p.IMEI 
inner join Phones_Infos pi on p.SKU = pi.SKU
inner join ServicePlans sp on op.Plan_ID = sp.Plan_ID;

-- /////////////
-- what to select from employees?

-- 1. Show which employees belong to which stores
-- add WHERE clause to filter
select e.Emp_Name, s.Store_ID from Stores s
inner join Employees e on e.Store_ID = s.Store_ID
order by e.Emp_Name asc;

-- 2. Show how many orders each employee has sold
-- add WHERE clause to filter
select e.Emp_Name, COUNT(*) as orderQty from Employees e
inner join Orders o on o.Emp_ID = e.Emp_ID
group by e.Emp_Name;

-- /////////////
-- what to select from phones and phones_infos

-- 1. List each phones sorted by sku
select pi.SKU, p.IMEI, pi.Manufacturer, pi.Phone_Name from Phones p
inner join Phones_Infos pi on p.SKU = pi.SKU;

-- 2. List Phone_Infos
select * from Phones_Infos;

-- misc
select * from ServicePlans;
select * from Phones;
select * from Phones_Infos;
select * from Employees;
select * from Stores;
select * from Orders;
select * from Orders_Products;

