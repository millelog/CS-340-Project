module.exports = function() {
	var express = require('express');
	var router = express.Router();

	
	/*
		function gets customers from db
	*/
	function getCustomers(res,mysql,context,complete){
		mysql.pool.query("SELECT Cust_ID, Customers.Cust_Name, Customers.Cust_Email, Customers.Cust_Phone_Number, Customers.Cust_Address_Street, Customers.Cust_Address_Zip FROM Customers",(error,results,fields)=>{
			if(error){
				res.write(JSON.stringify(error));
				res.end();
			}
			context.customers = results;
			complete();
		});
	}

  /*
   function gets single customer matching id
  */
  function getSingleCustomer(res,mysql,context,Cust_ID,complete){
    var sql = "Select Cust_ID, Cust_Name, Cust_Email, Cust_Phone_Number, Cust_Address_Street, Cust_Address_Zip from Customers where Cust_ID = ?";
    var inserts = [Cust_ID];

    mysql.pool.query(sql,inserts,(error,results,fields)=>{
      if(error){
        res.write(JSON.stringify(error));
        res.end();
      }
      context.customer = results[0];
      complete();
    });
  }

  /*
    function gets employee ids for add-order
  */
  function getEmpIDs(res,mysql,context,complete){
    mysql.pool.query("select Emp_ID as id, Emp_Name as name from Employees",(error,results,fields)=>{
      if(error){
        res.write(JSON.stringify(error));
        res.end();
      }
      context.employees = results;
      complete();
    });
  }

  /*
    function gets phone ids and names
  */
  function getPhoneNames(res,mysql,context,complete){
    mysql.pool.query("select SKU, Phone_Name from Phones_Infos",(error,results,fields)=>{
      if(error){
        res.write(JSON.stringify(error));
        res.end();
      }
      context.phonenames = results;
      complete();
    });
  }

  /*
    function gets plan ids and names
  */
  function getPlanIDs(res,mysql,context,complete){
    mysql.pool.query("select Plan_ID as planid, Plan_Name as planName from ServicePlans",(error,results,fields)=>{
      if(error){
        res.write(JSON.stringify(error));
        res.end();
      }
      context.phoneplans = results;
      complete();
    });
  }
	

  /*
    function gets order information to display
  */
  function getOrderInfos(res,mysql,context, Cust_ID, complete){
    var sql = "select Orders.Order_ID, Orders.Order_Date, Employees.Emp_Name, Phones_Infos.Phone_Name, ServicePlans.Plan_Name , Phones_Infos.Phone_Price from Orders inner join Employees on Employees.Emp_ID = Orders.Emp_ID inner join Phones on Phones.IMEI = Orders.IMEI inner join Phones_Infos on Phones_Infos.SKU = Phones.SKU inner join ServicePlans on Orders.Plan_ID = ServicePlans.Plan_ID where Cust_ID = ?";
    var inserts = [Cust_ID];
    mysql.pool.query(sql, inserts,(error,results,fields)=>{
      if(error){
        res.write(JSON.stringify(error));
        res.end();
      }
      context.orderinfos = results;
      complete();
    });
  }

  function searchCustomers(res,req,mysql,context,complete){
    var possible_inserts = [req.body.Cust_Name_Search, req.body.Cust_Email_Search, req.body.Cust_Phone_Number_Search, req.body.Cust_Address_Street_Search, req.body.Cust_Address_Zip_Search];

    var sql = "SELECT * FROM Customers WHERE ";
    var inserts = []
    possible_inserts.forEach(function(insert, i){
        if(insert){
          inserts.push(insert)
          switch(i){
              case 0:
                  sql+="Cust_Name=? AND ";break;
              case 1:
                  sql+="Cust_Email=? AND ";break;
              case 2:
                  sql+="Cust_Phone_Number=? AND ";break;
              case 3:
                  sql+="Cust_Address_Street=? AND ";break;
              case 4:
                  sql +="Cust_Address_Zip=? AND ";break;
          }
        }
    });
    var explode = sql.split(" ");
    explode.pop()
    explode.pop()
    sql = explode.join(' ')

    sql = mysql.pool.query(sql, inserts, (error, results, fields)=>{
          if(error){
              console.log(error)
              res.write(JSON.stringify(error));
              res.end();
          }else{
              context.customers = results;
              complete();
          }
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
    route to render update-customers page
  */
  router.get('/:Cust_ID', (req,res)=>{
    callbackCount = 0;
    var context = {};
    context.jsscripts = ["updatecustomers.js"]

    var mysql = req.app.get('mysql');

    getSingleCustomer(res,mysql,context,req.params.Cust_ID,complete);
    getEmpIDs(res,mysql,context,complete);
    getPhoneNames(res,mysql,context,complete);
    getPlanIDs(res,mysql,context,complete);
    getOrderInfos(res,mysql,context,req.params.Cust_ID,complete);

    function complete(){
      callbackCount++;
      if(callbackCount >=5){
        res.render('update-customers', context);
      }
    }

  });

  /*
    route to update customers
  */
  router.put('/:Cust_ID', (req,res)=>{
      var mysql = req.app.get('mysql');
      console.log(req.body)
    console.log(req.params.Cust_ID)  
    var sql = "UPDATE Customers SET Cust_Name=?,Cust_Email=?,Cust_Phone_Number=?,Cust_Address_Street=?,Cust_Address_Zip=? WHERE Cust_ID = ?";
    var inserts = [req.body.Cust_Name, req.body.Cust_Email, req.body.Cust_Phone_Number, req.body.Cust_Address_Street, req.body.Cust_Address_Zip, req.params.Cust_ID];
    
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
    function adds a new order, redirects to the same customer 'view' page it was sent from
  */
  router.post('/:id', (req,res)=>{
    console.log(req.body)
    var mysql = req.app.get('mysql');
    //create order, insert customer id, employee id, and order date
    var sql = "insert into Phones (IMEI, SKU) values (?,?)";
    var inserts = [req.body.IMEI, req.body.phoneselect];

    sql = mysql.pool.query(sql,inserts,(error,results,fields)=>{
      if(error){
        console.log(JSON.stringify(error))
        res.write(JSON.stringify(error));
        res.end();
      }
      else{
                sql = "insert into Orders (Cust_ID, Emp_ID, Order_Date, Plan_ID, IMEI) values (?,?,?,?,?)";
                inserts = [req.params.id, req.body.employeeselect, req.body.Order_Date,  req.body.planselect, req.body.IMEI];

                sql = mysql.pool.query(sql,inserts,(error,results,fields)=>{
                  if(error){
                    console.log(JSON.stringify(error))
                    res.write(JSON.stringify(error));
                    res.end();
                  }else{
                    res.status(200);
                    res.redirect('/orders/'); 
                  }
                });
                 
      }
    });        
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





	
    router.post('/customer_search', (req,res)=>{
        var callbackCount = 0;
        var context = {};       //object that will store sql results
        context.jsscripts = [];

        var mysql = req.app.get('mysql');

        searchCustomers(res,req,mysql,context,complete);

        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('customers', context);
            }
        }

    });
	return router;
}();
