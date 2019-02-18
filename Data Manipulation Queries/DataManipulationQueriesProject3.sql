INSERT INTO stores (store_phone_number, store_address_street, store_address_zip) VALUES (:store_phone_input, :store_address_street_input, :store_address_zip_input);

INSERT INTO employees (emp_name, store_id, emp_phone_number, emp_address_street, emp_address_zip) VALUES  (:emp_name_input, :store_id_input, :emp_phone_number_input, :emp_address_street_input, :emp_address_zip_input);

INSERT INTO customers (cust_name, cust_phone_number, cust_email, cust_address_street, cust_address_zip) VALUES  (:cust_name_input, :cust_phone_number_input, :cust_email_input, :cust_address_street_input, :cust_address_zip_input);

INSERT INTO orders (cust_id, emp_id, order_date) VALUES (:cust_id_input, :emp_id_input, :order_date_input);

INSERT INTO phone_infos (sku, manufacturer, model, phone_name, phone_price) VALUES (:sku_input, :manufacturer_input, :model_input, :phone_name_input, :phone_price_input);

INSERT INTO phones (imei, sku, plan_id) VALUES (:imei_input, :sku_input, :plan_id_input);

INSERT INTO serviceplans (plan_id, plan_cost, plan_name, plan_desc) VALUES (:plan_id_input, :plan_cost_input, :plan_name_input, :plan_desc_input);

INSERT INTO stores_customers (store_id, cust_id) VALUES (:stores_id_input, :cust_id_input);

INSERT INTO order_products (order_id, imei, plan_id) VALUES (:order_id_input, :imei_input, :plan_id_input);

--select stuff--
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

--update and delete--
UPDATE customers SET cust_name=:cust_name_update, cust_phone_number=:cust_phone_number_update,
cust_email=:cust_email_update,
cust_address_street=:cust_address_street_update,
cust_address_zip=:cust_address_zip_update WHERE cust_id=:cust_id_update;

DELETE FROM customers WHERE cust_id=:cust_id_delete;

UPDATE orders_products SET plan_id=:plan_id_update WHERE order_id=:order_id_update;

DELETE FROM orders_products WHERE order_id=:order_id_delete AND imei=:imei_delete;

--update and set to null
UPDATE employees SET store_id=NULL WHERE emp_id=:emp_id_update;

--delete
DELETE FROM stores_customers WHERE cust_id=:cust_id_delete_store AND store_id=:store_id_delete_cust;

DELETE FROM orders_products WHERE plan_id=:plan_id_delete;



