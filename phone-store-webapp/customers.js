module.exports = function() {
	var express = require('express');
	var router = express.Router();

	/*
		function renders customers.handlebars
	*/
	router.get('/', (req,res)=>{
		var callbackCount = 0;
		var context = {};		//object that will store sql results
		context.test = 'suhDudde';
		context.jsscripst = [];

		var mysql = req.app.get('mysql');

		//render handlebars
		res.render('customers',context)

	});

	return router;
}();