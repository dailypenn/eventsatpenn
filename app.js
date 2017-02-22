var express = require('express');
var app = express();
var path = require('path');
var nunjucks = require('nunjucks');

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
      res.render('index.jinja', {foo: user});
});

app.get('/calendar', function(req, res) {
      res.render('calendar.jinja', {foo: user});
});

app.get('/organization/new', function(req, res) {
      res.render('organization/new.jinja', {foo: user});
});

app.get('/organization/view', function(req, res) {
      res.render('organization/view.jinja', {foo: user});
});

app.get('/organization/:id', function(req, res) {
      res.render('organization/view.jinja', {foo: user, id: req.params['id']})
})

app.get('/events/new', function(req, res) {
      res.render('events/new.jinja', {foo: user});
});

app.get('/events/view', function(req, res) {
      res.render('events/view.jinja', {foo: user});
});

app.listen(process.env.PORT || 8000); //starts up the server
console.log('server is running');
