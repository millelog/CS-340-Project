var express = require('express');
var mysql = require('./dbcon.js');

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 4343);

app.get('/',function(req,res,next){
    res.render('index');
});

app.get('/newOrder', function(req,res,next){
  res.render(x)
});

app.get('/newCustomer',function(req,res,next){
    res.render('newCustomer');
});

app.get('/lookupCustomer',function(req,res,next){
    res.render('lookupCustomer');
});

app.get('/updateCustomer',function(req,res,next){
    res.render('updateCustomer');
});

app.get('/newPhone',function(req,res,next){
    res.render('newPhone');
});

app.get('/hireEmployee',function(req,res,next){
    res.render('hireEmployee');
});

app.get('/fireEmployee',function(req,res,next){
    res.render('fireEmployee');
});

app.get('/newStore',function(req,res,next){
    res.render('newStore');
});

app.get('/newServiceplan',function(req,res,next){
    res.render('newServiceplan');
});




app.use(function(req,res){
  res.status(404);
  res.render('404');
});

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
