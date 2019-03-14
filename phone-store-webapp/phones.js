module.exports = function(){
	var express = require('express');
	var router = express.Router();

		/*
			function gets single phone and returns its attributes
		*/
		function getSinglePhone(res,mysql,context,SKU,complete){
			var sql = "SELECT SKU, Manufacturer, Model, Phone_Name, Phone_Price FROM Phones_Infos WHERE SKU = ?";
			var inserts = [SKU];

			mysql.pool.query(sql,inserts,(error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.phone = results[0];
				complete();
			});
		}

		/*
			function gets phones from db
		*/
		function getPhones(res,mysql,context,complete){
			mysql.pool.query("SELECT Phones_Infos.SKU, Phones_Infos.Manufacturer, Phones_Infos.Model, Phones_Infos.Phone_Name, Phones_Infos.Phone_Price FROM Phones_Infos order by Phones_Infos.Manufacturer asc",(error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.phones = results;
				complete();
			});
		}

		/*
			route renders phones.handlebars
		*/
		router.get('/', (req,res)=>{
			var callbackCount = 0;
			var context = {};		//object that will store sql results
			context.jsscripts = ["deletephones.js","updatephones.js"];

			var mysql = req.app.get('mysql');
			
			getPhones(res,mysql,context,complete);

			function complete(){
	            callbackCount++;
	            if(callbackCount >= 1){
	                res.render('phones', context);
	            }
			}

		});

		/*
			route to render update-phone page
		*/
		router.get('/:SKU', (req,res)=>{
			callbackCount = 0;
			var context = {};
			context.jsscripts = ["updatephones.js"]

			var mysql = req.app.get('mysql');
			getSinglePhone(res,mysql,context,req.params.SKU,complete);

			function complete(){
				callbackCount++;
				if(callbackCount >=1){
					res.render('update-phones', context);
				}
			}

		});




		/*
			function adds a new phone, redirects to phones page after adding
		*/
		router.post('/', (req,res)=>{
			console.log(req.body)
			var mysql = req.app.get('mysql');
			var sql = "INSERT INTO Phones_Infos (SKU, Manufacturer, Model, Phone_Name, Phone_Price) VALUES (?,?,?,?,?)"
			//var sql = "insert into Employees (Emp_Name, Store_ID, Emp_Phone_Number, Emp_Address_Street, Emp_Address_Zip) values (?,?,?,?,?)";
			var inserts = [req.body.SKU, req.body.Manufacturer, req.body.Model, req.body.Phone_Name, req.body.Phone_Price];

			sql = mysql.pool.query(sql,inserts,(error,results,fields)=>{
				if(error){
					console.log(JSON.stringify(error))
					res.write(JSON.stringify(error));
					res.end();
				}
				else{
					res.redirect('/phones');
				}
			});  
		});

		/*
			route updates the attributes passed in inserts
		*/
		router.put('/:SKU', (req,res)=>{
        var mysql = req.app.get('mysql');
        console.log(req.body)
		console.log(req.params.SKU)	
		var sql = "UPDATE Phones_Infos SET Manufacturer=?,Model=?,Phone_Name=?,Phone_Price=? WHERE SKU =?";
		var inserts = [req.body.Manufacturer, req.body.Model, req.body.Phone_Name, req.body.Phone_Price, req.params.SKU];
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
			route deletes a phones
		*/
		router.delete('/:SKU', (req,res)=>{
			var mysql = req.app.get('mysql');
			var sql = "DELETE FROM Phones_Infos WHERE SKU = ?";
			var inserts = [req.params.SKU];

			sql = mysql.pool.query(sql, inserts, (error, results, fields)=>{
				if(error){
					console.log(error);
					res.write(JSON.stringify(error));
					res.status(400);
					res.end();
				}else{
					res.status(202).end();
				}
			});
		});



		return router;

}();
