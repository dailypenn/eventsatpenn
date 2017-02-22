var express = require('express');
var app = express();
var path = require('path');
var nunjucks = require('nunjucks');
var models = require('./app/models/index.js');

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

app.get('/test', function(req, res) {
  models.User.sync();

  models.User.create({pennKey: "agrav",
    firstName: "Alex",
    lastName: "Graves",
    student: true,
    faculty: false,
    fbID: "aa1e22"}
  );

  models.User.findAll({
      // include: [ models.Task ]
    }).then(function(users) {
      res.render('index.jinja', {
        users: users
      });
    });
})


app.listen(process.env.PORT || 8000);
console.log('server is running');
