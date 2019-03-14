module.exports = function() {
	var express = require('express');
	var router = express.Router();

	
	/*
		function gets all stores from db
	*/
	function getStores(res,mysql,context,complete){
		mysql.pool.query("SELECT Stores.Store_ID, Stores.Store_Phone_Number, Stores.Store_Address_Street, Stores.Store_Address_Zip FROM Stores",(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.stores = results;
			complete();
		});
	}

	/*
		function returns one store
	*/
	function getSingleStore(res,mysql,context,Store_ID,complete){
		// var sql = "UPDATE Stores SET Store_Phone_Number=?,Store_Address_Street=?,Store_Address_Zip=? WHERE Store_ID =?";
		
		var sql = "SELECT Store_ID, Store_Phone_Number, Store_Address_Street, Store_Address_Zip FROM Stores WHERE Store_ID =?";
		var inserts = [Store_ID]

		mysql.pool.query(sql,inserts,(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.store = results[0];
			complete();
		})
	}


	/*
		route renders stores.handlebars
	*/
	router.get('/', (req,res)=>{
		var callbackCount = 0;
		var context = {};		//object that will store sql results
		context.jsscripst = [];

		var mysql = req.app.get('mysql');

		getStores(res,mysql,context,complete);


		function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('stores', context);
            }
		}

	});


	/*
		route to render update-store page
	*/
	router.get('/:Store_ID', (req,res)=>{
		callbackCount = 0;
		var context = {};
		context.jsscripts = ["updatestores.js"]

		var mysql = req.app.get('mysql');
		getSingleStore(res,mysql,context,req.params.Store_ID,complete);

		function complete(){
			callbackCount++;
			if(callbackCount >=1){
				res.render('update-stores', context);
			}
		}

	});


	/*
		route to update store
	*/
	router.put('/:Store_ID', (req,res)=>{
	    var mysql = req.app.get('mysql');
	    console.log(req.body)
		console.log(req.params.Store_ID)	
		var sql = "UPDATE Stores SET Store_Phone_Number=?,Store_Address_Street=?,Store_Address_Zip=? WHERE Store_ID =?";
		var inserts = [req.body.Store_Phone_Number, req.body.Store_Address_Street, req.body.Store_Address_Zip, req.params.Store_ID];
		
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
		route adds a new customer, redirects to stores page after adding
	*/
	router.post('/', (req,res)=>{
		console.log(req.body)
		var mysql = req.app.get('mysql');
		var sql = "insert into Stores (Store_Phone_Number, Store_Address_Street, Store_Address_Zip) values (?,?,?)";
		var inserts = [req.body.Store_Phone_Number, req.body.Store_Address_Street, req.body.Store_Address_Zip];

		sql = mysql.pool.query(sql,inserts,(error,results,fields)=>{
			if(error){
				console.log(JSON.stringify(error))
				res.write(JSON.stringify(error));
				res.end();
			}
			else{
				res.redirect('/stores');
			}
		});
	});


	return router;

}();