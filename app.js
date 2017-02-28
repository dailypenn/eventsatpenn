var nunjucks = require('nunjucks');
var path     = require('path');
var models   = require('./app/models');
var express  = require('express');
var passport = require('passport');
var bodyParser = require('body-parser');
var FacebookStrategy = require('passport-facebook').Strategy
var authConfig = require('./app/config/auth.js');
var session  = require('express-session')
var app      = express();

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
  callbackURL     : authConfig.facebookAuth.callbackURL,
  profileFields: ['id', 'displayName', 'photos', 'email', 'profileUrl', 'first_name', 'last_name', 'education', 'accounts']
}, function(accessToken, refreshToken, profile, done) {
  process.nextTick(function () {
    //Check whether the User exists or not using profile.id
    console.log(profile);
    return done(null, profile);
  });
}));

app.set('port', process.env.PORT || 8000);

app.use(express.static('app/public'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({ secret: authConfig.sessionSecret }));
app.use(passport.initialize());
app.use(passport.session());
app.use(function(req, res, next) { // Global app variables
  res.locals.user = req.user;
  next();
});

nunjucks.configure('app/views', {
    autoescape: true,
    express: app
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

require('./app/controllers')(app); // Allow for Routing
app.listen(app.get('port')); //starts up the server
console.log('Server running on port', app.get('port'));
