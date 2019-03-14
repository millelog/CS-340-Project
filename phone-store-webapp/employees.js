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
		mysql.pool.query("SELECT Employees.Emp_ID, Employees.Emp_Name, Employees.Store_ID, Employees.Emp_Phone_Number, Employees.Emp_Address_Street, Employees.Emp_Address_Zip FROM Employees",(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.employees = results;
			complete();
		});
	}

	/*
		function gets single employees from db
	*/
	function getSingleEmployee(res,mysql,context,Emp_ID,complete){
		var sql = "SELECT Emp_ID, Emp_Name, Store_ID, Emp_Phone_Number, Emp_Address_Street, Emp_Address_Zip FROM Employees WHERE Emp_ID = ?" ;
		var inserts = [Emp_ID];

		mysql.pool.query(sql,inserts,(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.employee = results[0];
			complete();
		});
	}



	/*
		function renders employees.handlebars
	*/
	router.get('/', (req,res)=>{
		var callbackCount = 0;
		var context = {};		//object that will store sql results
		context.jsscripts = [];

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
		route to render update-employee page
	*/
	router.get('/:Emp_ID', (req,res)=>{
		callbackCount = 0;
		var context = {};
		context.jsscripts = ["updateemployees.js"]

		var mysql = req.app.get('mysql');

		getStoreIDs(res,mysql,context,complete);

		getSingleEmployee(res,mysql,context,req.params.Emp_ID,complete);

		function complete(){
			callbackCount++;
			if(callbackCount >=2){
				res.render('update-employees', context);
			}
		}

	});


	/*
		route to update employees
	*/
	router.put('/:Emp_ID', (req,res)=>{
	    var mysql = req.app.get('mysql');
	    console.log(req.body)
		console.log(req.params.Emp_ID)	
		var sql = "UPDATE Employees SET Emp_Name=?,Store_ID=?,Emp_Phone_Number=?,Emp_Address_Street=?,Emp_Address_Zip=? WHERE Emp_ID = ?";
		var inserts = [req.body.Emp_Name, req.body.Store_ID, req.body.Emp_Phone_Number, req.body.Emp_Address_Street, req.body.Emp_Address_Zip, req.params.Emp_ID];
		
		sql = mysql.pool.query(sql, inserts, (error, results, fields)=>{
			if(error){
	            console.log(error)
	            res.write(JSON.stringify(error));
	            res.end();
	        }else{
	            res.status(200);
	            res.end();
			}
		});
	});


	/*
		function adds a new employee, redirects to employee page after adding
	*/
	router.post('/', (req,res)=>{
		console.log(req.body)
		var mysql = req.app.get('mysql');
		var sql = "insert into Employees (Emp_Name, Store_ID, Emp_Phone_Number, Emp_Address_Street, Emp_Address_Zip) values (?,?,?,?,?)";
		var inserts = [req.body.Emp_Name, req.body.Store_ID, req.body.Emp_Phone_Number, req.body.Emp_Address_Street, req.body.Emp_Address_Zip];

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
