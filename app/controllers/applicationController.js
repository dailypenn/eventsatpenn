module.exports = function(app){
  var User = require('../models').User;

  app.get('/', function(req, res) {
    User.sync(); // This needs to be fixed
    User.all().then(function(users) {
      res.render('index.jinja', {users: users});
    });
  });

  app.get('/calendar', function(req, res) {
    res.render('calendar.jinja', {});
  });
};
