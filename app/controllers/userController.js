module.exports = function(app){
  var User = require('../models').User;

  app.post('/user', function(req, res) {
    console.info('Creating user with id ' + req.body.id);
    User.create({
      id: req.body.id,
      firstName: req.body.first_name,
      lastName: req.body.last_name,
      email: req.body.email
    }).then(function(newUser) {
      console.info('Successfully created user', newUser.get('firstName'));
      res.send({status: 'success'});
    });
  });

  // app.get('/user/:id', function(req, res) {
  //   User.findOne({
  //     where: {
  //       id: req.params.id
  //     }
  //   }).then(function(user) {
  //     res.render('users/view.jinja', {user: user})
  //   });
  // })

  app.get('/profile', function(req, res) {
    res.render('users/view.jinja');
  })
};
