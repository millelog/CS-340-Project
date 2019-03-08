module.exports = function(){
	var express = require('express');
	var router = express.Router();


		/*
			function gets phones from db
		*/
		function getPhones(res,mysql,context,complete){
			mysql.pool.query("SELECT Phones_Infos.SKU, Phones_Infos.Manufacturer, Phones_Infos.Model, Phones_Infos.Phone_Name, Phones_Infos.Phone_Price FROM Phones_Infos",(error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.phones = results;
				complete();
			});
		}


		/*
			function renders phones.handlebars
		*/
		router.get('/', (req,res)=>{
			var callbackCount = 0;
			var context = {};		//object that will store sql results
			context.jsscripst = [];

			var mysql = req.app.get('mysql');
			
			getPhones(res,mysql,context,complete);

			function complete(){
	            callbackCount++;
	            if(callbackCount >= 1){
	                res.render('phones', context);
	            }
			}

		});



		return router;

}();
