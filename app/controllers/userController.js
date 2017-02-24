module.exports = function(app){
  var User = require('../models').User;

  app.post('/user', function(req, res) {
    var newPennKey = req.body.pennKey;
    console.log('>> Creating user for pennKey', newPennKey);
    // Sync to DB, then create user
    User.sync().then(function() {
      User.create({
        pennKey: newPennKey,
        firstName: req.body.fName, // FIXME when we have pennkey
        lastName: req.body.lName,
        email: req.body.email,
        student: true, // FIXME when we have pennkey
        faculty: false,
        fbID: "xxxxxx"
      }).then(function(newUser) {
        console.log('>> Successfully created user for pennKey', newUser.get('pennKey'));
        res.redirect('/user/' + newUser.id);
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
