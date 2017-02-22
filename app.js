var express = require('express');
var app = express();
var path = require('path');
var nunjucks = require('nunjucks');

var models = require('./app/models');
require('./app/controllers')(app); // Routing

app.set('views', path.join(__dirname, './apps/views'));
app.use(express.static('public'));

nunjucks.configure('app/views', {
    autoescape: true,
    express: app
});

var user = {
  name: "hello",
  email: "email"
}

app.get('/', function(req, res) {
  res.render('index.jinja', {});
});

app.get('/test', function(req, res) {
  var User = models.User;

  User.sync();

  User.all({
      // include: [ models.Task ]
    }).then(function(users) {
      res.render('index.jinja', {
        users: users
      });
    });
})

app.get('/calendar', function(req, res) {
  res.render('calendar.jinja', {});
});

app.listen(process.env.PORT || 8000); //starts up the server
console.log('server is running');
