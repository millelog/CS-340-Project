module.exports = function(){
	var express = require('express');
	var router = express.Router();

	/*
		function gets service plans from db
	*/
	function getServicePlans(res,mysql,context,complete){
		mysql.pool.query("SELECT ServicePlans.Plan_Name, ServicePlans.Plan_Cost, ServicePlans.Plan_Desc",(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.service_plans = results;
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
		
		getServicePlans(res,mysql,context,complete);


		function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('service_plans', context);
            }
		}

	});

	/*
		function adds a new service plan, redirects to service plan page after adding
	*/
	router.post('/', (req,res)=>{
		console.log(req.body)
		var mysql = req.app.get('mysql');
		var sql = "insert into ServicePlans (Plan_Name, Plan_Cost, Plan_Desc) values (?,?,?)";
		var inserts = [req.body.plan_name, req.body.plan_cost, req.body.plan_desc];

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
