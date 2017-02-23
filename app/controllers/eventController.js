module.exports = function(app){
  var PlannedEvent = require('../models').Event;

  app.get('/event', function(req, res) {
    PlannedEvent.sync();
    PlannedEvent.findAll().then(function(events) {
      res.render('events/all.jinja', {events: events});
    })
  });

  app.get('/event/new', function(req, res) {
    res.render('events/new.jinja', {});
  });

  app.get('/event/view', function(req, res) {
    res.render('events/view.jinja', {});
  });

  app.get('/event/:id', function(req, res) {
        res.render('events/view.jinja', {id: req.params['id']})
  })
};
