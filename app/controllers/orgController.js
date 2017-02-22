module.exports = function(app){
  app.get('/organization/new', function(req, res) {
        res.render('organization/new.jinja', {});
  });

  app.get('/organization/view', function(req, res) {
        res.render('organization/view.jinja', {});
  });

  app.get('/organization/:id', function(req, res) {
        res.render('organization/view.jinja', {id: req.params['id']})
  })
};
