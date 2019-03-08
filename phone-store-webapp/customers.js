module.exports = function() {
	var express = require('express');
	var router = express.Router();

	
	/*
		function gets customers from db
	*/
	function getCustomers(res,mysql,context,complete){
		mysql.pool.query("SELECT Customers.Cust_Name, Customers.Cust_Email, Customers.Cust_Phone_Number, Customers.Cust_Address_Street, Customers.Cust_Address_Zip FROM Customers",(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.customers = results;
			complete();
		});
	}

	/*
		function renders customers.handlebars
	*/
	router.get('/', (req,res)=>{
		var callbackCount = 0;
		var context = {};		//object that will store sql results
		context.jsscripst = [];

		var mysql = req.app.get('mysql');

		getCustomers(res,mysql,context,complete);

		function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('customers', context);
            }
		}

	});

	/*
		function adds a new customer, redirects to customers page after adding
	*/
	router.post('/', (req,res)=>{
		console.log(req.body)
		var mysql = req.app.get('mysql');
		var sql = "insert into Customers (Cust_Name, Cust_Email, Cust_Phone_Number, Cust_Address_Street, Cust_Address_Zip) values (?,?,?,?,?)";
		var inserts = [req.body.Cust_Name, req.body.Cust_Email, req.body.Cust_Phone_Number, req.body.Cust_Address_Street, req.body.Cust_Address_Zip];

		sql = mysql.pool.query(sql,inserts,(error,results,fields)=>{
			if(error){
				console.log(JSON.stringify(error))
				res.write(JSON.stringify(error));
				res.end();
			}
			else{
				res.redirect('/customers');
			}
		});
	});


	return router;
}();