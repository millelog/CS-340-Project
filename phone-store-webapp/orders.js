module.exports = function(){
	var express = require('express');
	var router = express.Router();

	//function to get orders
	function getOrders(res,mysql,context,complete){
		mysql.pool.query("SELECT Orders.Order_ID, Customers.Cust_Name, Orders.Order_Date FROM Orders LEFT JOIN Customers ON Orders.Cust_ID = Customers.Cust_ID",
			(error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.orders = results;
				complete();
			});
	}

	function getCustomers(res,mysql,context,complete){
		mysql.pool.query("SELECT * FROM Customers",
			(error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.customers = results;
				complete();
		});
	}

	function getServicePlans(res,mysql,context,complete){
		mysql.pool.query("SELECT * FROM ServicePlans",
			(error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.service_plans = results;
				complete();
		});
	}

	function getEmployees(res,mysql,context,complete){
		mysql.pool.query("SELECT * FROM Employees",
			(error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.employees = results;
				complete();
		});
	}

	function getPhoneInfo(res,mysql,context,complete){
		mysql.pool.query("SELECT DISTINCT Phones.IMEI, Phones_Infos.SKU, Phones_Infos.Manufacturer, Phones_Infos.Model, Phones_Infos.Phone_Name, Phones_Infos.Phone_Price FROM Phones LEFT JOIN Phones_Infos ON Phones.SKU=Phones_Infos.SKU",
			(error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.phones = results;
				complete();
		});
	}

	/*
	//not sure if going to implement this function, removed the view button from the orders.handlebars file
	function to view the selected order. Gets passed the order id
	and then sql query returns the order id, the phone sku, phone name, 
	customer name, service plan name, and order date for that order

	*/
	function viewAnOrder(res,mysql,id,complete){
		var sql = "SELECT Orders.Order_ID, Phones.SKU, Phones_Infos.Phone_Name, Customers.Cust_Name, ServicePlans.Plan_Name, Orders.Order_Date  FROM Orders LEFT JOIN Orders_Products ON Orders_Products.Order_ID = Orders.Order_ID LEFT JOIN Phones ON Orders_Products.IMEI = Phones.IMEI LEFT JOIN Phones_Infos ON Phones.SKU = Phones_Infos.SKU LEFT JOIN Customers ON Orders.Cust_ID = Customers.Cust_ID LEFT JOIN ServicePlans ON Orders_Products.Plan_ID = ServicePlans.Plan_ID WHERE Orders.Order_ID = ?";
		var inserts = [id];
		mysql.pool.query(sql, inserts, (error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.anOrder = results[0];
			complete();
		});
	}
		
	router.get('/add_order', (req,res)=>{
		callbackCount = 0;
		var context = {};
		var mysql = req.app.get('mysql');

		getCustomers(res,mysql,context,complete);
		getServicePlans(res,mysql,context,complete);
		getPhoneInfo(res,mysql,context,complete);
		getEmployees(res,mysql,context,complete);

		function complete(){
			callbackCount++;
			if(callbackCount >=4){
				res.render('add-order', context);
			}
		}
	});

	router.post('/add_order', (req,res)=>{
		var mysql = req.app.get('mysql');
		var sql = "insert into Orders (Order_ID, Cust_ID, Emp_ID, Order_Date) values (?,?,?,?)";
		var inserts = [req.body.Order_ID, req.body.Cust_ID, req.body.Emp_ID, req.body.Order_Date];
		sql = mysql.pool.query(sql, inserts,(error,results,fields)=>{
			if(error){
				console.log(JSON.stringify(error))
				res.write(JSON.stringify(error));
				res.end();
			}
			else{
				res.redirect('/orders');
				}
			});
		});

	/*
		function that renders orders.handlebars
		currently, the only javascript function is getOrders.
		if more is added, increase if(callbackCount) requirement
		to match the number of functions called
	*/
	router.get('/', (req,res)=>{
		var callbackCount = 0;
		var context = {};		//object that will store sql results
		context.jsscripts = [];

		var mysql = req.app.get('mysql');
		//getOrders
		getOrders(res,mysql,context,complete);

		function complete(){
			callbackCount++;
			if(callbackCount >= 1){
				res.render('orders', context);
			}
		}
	});



	return router;
}();
