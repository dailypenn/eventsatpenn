module.exports = function(app){
  var User = require('../models').User;

  app.post('/user', function(req, res) {
    console.log('>> Creating user');
    // Sync to DB, then create user
    User.sync().then(function() {
      User.create({
        firstName: req.body.first_name,
        lastName: req.body.last_name,
        email: req.body.email,
        fbID: req.body.id
      }).then(function(newUser) {
        console.log('>> Successfully created user', newUser.get('firstName'));
        res.send({status: 'success'});
      });
    });
  });

  function getUser(userId, callback) {
    User.findOne({
      where: {
        id: userId
      }
    }).then(function(user) {
      callback(user);
    });
  };

  app.get('/user/:id', function(req, res) {
    User.findOne({
      where: {
        id: req.params.id
      }
    }).then(function(user) {
      res.render('users/view.jinja', {user: user})
    });
  })

};
