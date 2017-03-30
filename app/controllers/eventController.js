module.exports = function(app){
  var PlannedEvent = require('../models').Event;

  // app.get('/org/:org_id/event', function(req, res) {
  //   PlannedEvent.sync();
  //   PlannedEvent.findAll().then(function(events) {
  //     res.render('events/all.jinja', {events: events});
  //   })
  // });

  app.get('/org/:org_id/event/new', function(req, res) {
    res.render('events/new', {});
  });

  app.get('/org/:org_id/event/:id', function(req, res) {
        res.render('events/view', {id: req.params['id']})
  })
};
