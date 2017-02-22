module.exports = function(app){
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
