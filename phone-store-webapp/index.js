var express = require('express');
var handlebars = require('express-handlebars').create({defaultLayout: 'main'});
var app = express();
var bodyParser = require('body-parser');
var mysql = require('./dbcon.js');

var PORT = 8845;

//handlebars middleware
app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');

//body parser
app.use(bodyParser.urlencoded({extended:true}));
app.set('mysql', mysql);


//routes
app.use('/', express.static('public'));	
app.use('/static', express.static('public'));
app.use('/orders', require('./orders.js'));
app.use('/customers', require('./customers.js'));
app.use('/employees', require('./employees.js'));
// app.use('/stores', require('./stores.js'));
// app.use('/phones', require('./phones.js'));
app.use('/service_plans', require('./service_plans.js'));

app.use((req,res)=>{
	res.status(404);
	res.render('404');
});

app.use((err,req,res,next)=>{
	console.error(err.stack);
	res.status(500);
	res.render('500');
});

app.listen(PORT, ()=> console.log(`Server started on port ${PORT}; press Ctrl-C to terminate.`));
