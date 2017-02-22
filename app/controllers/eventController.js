module.exports = function(app){
  app.get('/events/new', function(req, res) {
    res.render('events/new.jinja', {});
  });

  app.get('/events/view', function(req, res) {
    res.render('events/view.jinja', {});
  });
};
