var express       = require('express');
var nunjucks      = require('nunjucks');
var winston       = require('winston')
var bodyParser    = require('body-parser');
var cookieParser  = require('cookie-parser');
var cookieSession = require('cookie-session');
var authConfig    = require('./config/auth.js');
var app           = express();

global.__base = __dirname + '/';

app.set('name', 'Events@Penn');
app.set('port', process.env.PORT || 8000);
app.use(express.static('app/public'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(cookieSession({
  name   : authConfig.session.cookieName,
  secret : authConfig.session.secret,
  maxAge : 1000 * 60 * 60 * 24           // 24 hrs in miliseconds
}));

winston.setLevels({
  logs  : 4,
  info  : 3,
  debug : 2,
  warn  : 1,
  error : 0
});

winston.addColors({
  logs  : 'green',
  info  : 'cyan',
  debug : 'grey',
  warn  : 'yellow',
  error : 'red'
});

winston.remove(winston.transports.Console)
winston.add(winston.transports.Console, {
  level: 'logs',
  prettyPrint: true,
  colorize: true,
  silent: false,
  timestamp: false
});

// App middleware
app.use(function(req, res, next) {
  // Set global app variables
  if (res.locals && req.session.passport) {
    res.locals.user = req.session.passport.user; // pass user to all templates
  }
  // Check authentication
  var securePaths = ['/org/new', '/profile'];
  var hasUser = req.session.passport && req.session.passport.user;
  if (!hasUser && securePaths.indexOf(req.path) > -1) {
    res.redirect('/'); // TODO: Add error message or login page for this case
    return;
  }
  next();
});

// Nunjucks template configuration
nunjucks.configure('app/views', {
  autoescape: true,
  express: app
});

require('./app/controllers')(app); // Allow for Routing
app.listen(app.get('port')); //starts up the server
winston.logs('Server running on port', app.get('port'));
