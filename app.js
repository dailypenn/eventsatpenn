var nunjucks = require('nunjucks');
var path     = require('path');
var models   = require('./app/models');
var express  = require('express');
var passport = require('passport');
var bodyParser = require('body-parser');
// var cookieParser      =     require('cookie-parser')
var FacebookStrategy = require('passport-facebook').Strategy
var authConfig = require('./app/config/auth.js');
var session  = require('express-session')
var app      = express();
var routes   = require('./app/controllers')(app); // Routing

// Passport session setup.
passport.serializeUser(function(user, done) {
  done(null, user);
});
passport.deserializeUser(function(obj, done) {
  done(null, obj);
});

passport.use(new FacebookStrategy({
  clientID        : authConfig.facebookAuth.clientID,
  clientSecret    : authConfig.facebookAuth.clientSecret,
  callbackURL     : authConfig.facebookAuth.callbackURL
}, function(accessToken, refreshToken, profile, done) {
  process.nextTick(function () {
    //Check whether the User exists or not using profile.id
    console.log(profile);
    return done(null, profile);
  });
}));

app.set('port', process.env.PORT || 8000);

app.use(express.static('app/public'));
// app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({ secret: authConfig.sessionSecret }));
app.use(passport.initialize());
app.use(passport.session());

nunjucks.configure('app/views', {
    autoescape: true,
    express: app
});

app.get('/', function(req, res){
      console.log(req.user);
  //     console.log(req.isAuthenticated());
  res.render('index.jinja', { user: req.user });
});

app.get('/auth/facebook', passport.authenticate('facebook'));

app.get('/auth/facebook/callback', passport.authenticate('facebook', {
  successRedirect : '/',
  failureRedirect: '/login'
}), function(req, res) {
  res.redirect('/');
});

app.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
});

function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) { return next(); }
  res.redirect('/login')
}

app.listen(app.get('port')); //starts up the server
console.log('Server running on port', app.get('port'));
