module.exports = function(){
	var express = require('express');
	var router = express.Router();

	/*
		function gets service plans from db
	*/
	function getServicePlans(res,mysql,context,complete){
		mysql.pool.query("SELECT ServicePlans.Plan_ID, ServicePlans.Plan_Name, ServicePlans.Plan_Cost, ServicePlans.Plan_Desc from ServicePlans",(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.service_plans = results;
			complete();
		});
	}

	/*
		function returns single service plan that matches the ID
	*/
	function getSinglePlan(res,mysql,context,Plan_ID,complete){
		var sql ="SELECT Plan_ID, Plan_Cost, Plan_Name, Plan_Desc FROM ServicePlans WHERE Plan_ID = ?";
		var inserts = [Plan_ID];

		mysql.pool.query(sql, inserts, (error,results,fields)=>{
				if(error){
					res.write(JSON.stringify(error));
					res.end();
				}
				context.plan = results[0];
				complete();
		});

	}


	/*
		function renders customers.handlebars
	*/
	router.get('/', (req,res)=>{
		var callbackCount = 0;
		var context = {};		//object that will store sql results
		context.jsscripts = ["updateplans.js","deletephones.js"];

		var mysql = req.app.get('mysql');
		
		getServicePlans(res,mysql,context,complete);


		function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('service_plans', context);
            }
		}

	});


	/*
		route to render update-plans page
	*/
	router.get('/:Plan_ID', (req,res)=>{
		callbackCount = 0;
		var context = {};
		context.jsscripts = ["updateplans.js", "deletephones.js"]

		var mysql = req.app.get('mysql');
		getSinglePlan(res,mysql,context,req.params.Plan_ID,complete);

		function complete(){
		callbackCount++;
			if(callbackCount >=1){
				res.render('update-plans', context);
			}
		}	

	})


	

	/*
		route to update phone
	*/
	router.put('/:Plan_ID', (req,res)=>{
	    var mysql = req.app.get('mysql');
	    console.log(req.body)
		console.log(req.params.Plan_ID)	

		var sql = "UPDATE ServicePlans SET Plan_Cost=?,Plan_Name=?,Plan_Desc=? WHERE Plan_ID =?";
		var inserts = [req.body.Plan_Cost, req.body.Plan_Name, req.body.Plan_Desc, req.params.Plan_ID];
		
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
		function adds a new service plan, redirects to service plan page after adding
	*/
	router.post('/', (req,res)=>{
		console.log(req.body)
		var mysql = req.app.get('mysql');
		
		var sql = "INSERT INTO ServicePlans(Plan_Name, Plan_Cost,  Plan_Desc) VALUES (?,?,?)";
		var inserts = [req.body.Plan_Name, req.body.Plan_Cost, req.body.Plan_Desc];

		sql = mysql.pool.query(sql,inserts,(error,results,fields)=>{
			if(error){
				console.log(JSON.stringify(error))
				res.write(JSON.stringify(error));
				res.end();
			}
			else{
				res.redirect('/service_plans');
			}
		});
	});




	return router;

}();
