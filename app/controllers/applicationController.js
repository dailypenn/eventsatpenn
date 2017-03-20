module.exports = function(app){

  app.get('/', function(req, res){
    res.render('index.jinja');
  });

  app.get('/calendar', function(req, res) {
    res.render('calendar.jinja', {});
  });
};
