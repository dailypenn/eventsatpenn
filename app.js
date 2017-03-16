var nunjucks = require('nunjucks');
var path     = require('path');
var models   = require('./app/models');
var express  = require('express');
var passport = require('passport');
var bodyParser = require('body-parser');
var FacebookStrategy = require('passport-facebook').Strategy
var authConfig = require('./app/config/auth.js');
var session  = require('express-session');
var FB       = require('fb');
var app      = express();

// Passport session setup.
passport.serializeUser(function(user, done) {
  done(null, user);
});
passport.deserializeUser(function(obj, done) {
  done(null, obj);
});


// FB config
FB.options({
  appId:          authConfig.facebookAuth.clientID,
  appSecret:      authConfig.facebookAuth.clientSecret,
  redirectUri:    authConfig.facebookAuth.callbackURL
});


passport.use(new FacebookStrategy({
  clientID        : authConfig.facebookAuth.clientID,
  clientSecret    : authConfig.facebookAuth.clientSecret,
  callbackURL     : authConfig.facebookAuth.callbackURL,
  profileFields: ['id', 'displayName', 'photos', 'email', 'profileUrl', 'first_name', 'last_name', 'education', 'accounts']
}, function(accessToken, refreshToken, profile, done) {
  process.nextTick(function () {

    models.User.findOne({ where: { id: profile.id }}).then(function(user) {
      if (!user) {
        console.log('>> New User! Creating ' + profile.id);
        models.User.create({
          id: profile.id,
          displayName: profile.displayName,
          firstName: profile.name.givenName,
          lastName: profile.name.familyName,
          email: profile.emails[0].value,
          photoURL: profile.photos[0].value,
          fbLink: profile.profileUrl
        }).then(function(newUser) {
          newUser.save();
          console.log('>> Successfully created user', newUser.get('id'));
        });
      } else {
        console.log('>> Found user. Redirecting to ' + profile.id);
      }
    });
    // console.log(profile);
    return done(null, profile);
  });
}));

app.set('port', process.env.PORT || 8000);

app.use(express.static('app/public'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({ secret: authConfig.sessionSecret }));
app.use(passport.initialize());
app.use(passport.session());

app.use(function(req, res, next) { // Set global app variable
  res.locals.user = req.user;
  next();
});

nunjucks.configure('app/views', {
  autoescape: true,
  express: app
});

app.get('/auth/facebook', passport.authenticate('facebook', {
  scope: ['public_profile', 'email', 'user_events', 'manage_pages']
}));

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
