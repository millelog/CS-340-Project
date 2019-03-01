var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_kuangx',
  password        : '1265',
  database        : 'cs340_kuangx'
});

module.exports.pool = pool;
