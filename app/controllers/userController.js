module.exports = function(app){
  app.post('/user', function(req, res) {
    console.log('>> Creating user for pennKey ', req.body.pennKey);
    res.send(req.body.pennKey + ' ' + req.body.fName + req.body.lName);
  });
};
