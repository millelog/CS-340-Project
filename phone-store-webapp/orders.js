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
	

	router.get('/', (req,res)=>{
		var callbackCount = 0;
		var context = {};
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