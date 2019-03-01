var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'hellouser',
  password        : 'default',
  database        : 'hellodb'
});

module.exports.pool = pool;
