module.exports = function(){
	var express = require('express');
	var router = express.Router();


	function getStoreIDs(res,mysql,context,complete){
		mysql.pool.query("select Store_ID as id from Stores", (error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.stores = results;
			complete();
		});
	}
	/*
		function gets employees from db
	*/
	function getEmployees(res,mysql,context,complete){
		mysql.pool.query("SELECT Employees.EMP_Name, Employees.Store_ID, Employees.EMP_Phone_Number, Employees.EMP_Address_Street, Employees.Emp_Address_Zip FROM Employees",(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.employees = results;
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
		
		getStoreIDs(res,mysql,context,complete);
		getEmployees(res,mysql,context,complete);


		function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('employees', context);
            }
		}

	});

	/*
		function adds a new employee, redirects to employee page after adding
	*/
	router.post('/', (req,res)=>{
		console.log(req.body)
		var mysql = req.app.get('mysql');
		var sql = "insert into Employees (EMP_Name, Store_ID, EMP_Phone_Number, EMP_Address_Street, Emp_Address_Zip) values (?,?,?,?,?)";
		var inserts = [req.body.EMP_Name, req.body.Store_ID, req.body.EMP_Phone_Number, req.body.EMP_Address_Street, req.body.Emp_Address_Zip];

		sql = mysql.pool.query(sql,inserts,(error,results,fields)=>{
			if(error){
				console.log(JSON.stringify(error))
				res.write(JSON.stringify(error));
				res.end();
			}
			else{
				res.redirect('/employees');
			}
		});
	});




	return router;

}();