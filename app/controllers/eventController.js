module.exports = function(app){
  app.get('/event/new', function(req, res) {
    res.render('events/new.jinja', {});
  });

  app.get('/event/view', function(req, res) {
    res.render('events/view.jinja', {});
  });
};
