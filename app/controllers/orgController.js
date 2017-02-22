module.exports = function(app){
  var Org = require('../models').Org;

  app.get('/org', function(req, res) {
    Org.sync();
    Org.findAll().then(function(orgs) {
      res.render('orgs/all.jinja', {orgs: orgs});
    })
  });

  app.get('/org/new', function(req, res) {
        res.render('orgs/new.jinja', {});
  });

  app.get('/org/view', function(req, res) {
        res.render('orgs/view.jinja', {});
  });

  app.get('/org/:id', function(req, res) {
        res.render('orgs/view.jinja', {id: req.params['id']})
  })
};
