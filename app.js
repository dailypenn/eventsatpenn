var express = require('express');
var app = express();
var path = require('path');
var nunjucks = require('nunjucks');

app.set('views', path.join(__dirname, 'views'));
app.use(express.static('public'));

nunjucks.configure('views', {
    autoescape: true,
    express: app
});


app.get('/', function(req, res) {
      res.render('index.html', {foo: 'world'});
});


app.listen(4000);
console.log('server is running');

