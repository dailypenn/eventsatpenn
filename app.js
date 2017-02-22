var nunjucks = require('nunjucks');
var path     = require('path');
var models   = require('./app/models');
var express  = require('express');
var app      = express();
var routes   = require('./app/controllers')(app); // Routing

app.use(express.static('app/public'));
app.set('port', process.env.PORT || 8000);

nunjucks.configure('app/views', {
    autoescape: true,
    express: app
});

app.listen(app.get('port')); //starts up the server
console.log('Server running on port', app.get('port'));
