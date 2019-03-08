module.exports = function() {
	var express = require('express');
	var router = express.Router();

	
	/*
		function gets stores from db
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
		function renders stores.handlebars
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
		function adds a new customer, redirects to stores page after adding
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