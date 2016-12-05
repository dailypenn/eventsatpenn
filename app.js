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

var user = {
  name: "hello",
  email: "email"
}

app.get('/', function(req, res) {
      res.render('index.jinja', {foo: user});
});


app.listen(process.env.PORT || 8000);
console.log('server is running');
