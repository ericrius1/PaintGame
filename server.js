var express = require('express')
var app = express();
app.set('port', (process.env.PORT || 5000))

var router = express.Router();

router.get('/', function(req, res){
  console.log('hello!!')
})

app.listen(app.get('port'), function() {
  console.log("SHNUUUUUR Node app is running at localhost:" + app.get('port'))
})