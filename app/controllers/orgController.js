module.exports = function(app){
  var Org = require('../models').Org;
  var User = require('../models').User;

  var UserController = require('./userController.js');

  app.get('/org', function(req, res) {
    Org.sync();
    Org.findAll().then(function(orgs) {
      res.render('orgs/all.jinja', {orgs: orgs});
    })
  });

  app.post('/org', function(req, res) {
    console.log('>> Creating org ', req.body.name);
    // Sync to DB, then create org
    Org.sync().then(function() {
      Org.create({
        name: req.body.name,
        website: req.body.website,
        fbPage: req.body.fbURL
      }).then(function(newOrg) {
        console.log('>> Successfully created org', newOrg.get('name'));

        //Get userId from current session
        // var userId = req.session.userId;
        User.findById(1).then(function(user) {
          user.addOrg(newOrg, {});
        });
        //Add the org as an association of the user
        // UserController(userId, function (user) {
        // });

        res.redirect('/org/' + newOrg.id);
      });
    });
  });

  app.get('/org/new', function(req, res) {
    res.render('orgs/new.jinja', {});
  });

  app.get('/org/view', function(req, res) {
    res.render('orgs/view.jinja', {});
  });

  app.get('/org/:id', function(req, res) {
    Org.findOne({
      where: {
        id: req.params.id
      }
    }).then(function(org) {
      res.render('orgs/view.jinja', {org: org})
    });
  })
};
