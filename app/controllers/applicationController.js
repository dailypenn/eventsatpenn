module.exports = function(app){
  var User = require('../models').User;

  // app.get('/', function(req, res) {
  //   User.all().then(function(users) {
  //     console.log(req.user);
  //     console.log(req.isAuthenticated());
  //     res.render('index.jinja', {user: req.user, users: users});
  //   });
  // });

  app.get('/calendar', function(req, res) {
    res.render('calendar.jinja', {});
  });
};
