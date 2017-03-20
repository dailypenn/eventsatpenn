module.exports = function(app){

  app.get('/', function(req, res){
    console.log(req.session);
    if (req.session.number !== undefined) {
      req.session.number += 1
    } else {
      req.session.number = 0
    }
    res.render('index.jinja');
  });

  app.get('/calendar', function(req, res) {
    res.render('calendar.jinja', {});
  });
};
