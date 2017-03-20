var nunjucks = require('nunjucks');
var path     = require('path');
var models   = require('./app/models');
var express  = require('express');
var passport = require('passport');
var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser');
var cookieSession = require('cookie-session');
var FacebookStrategy = require('passport-facebook').Strategy
var authConfig = require('./app/config/auth.js');
var session  = require('express-session');
var FB       = require('fb');
var app      = express();

app.set('port', process.env.PORT || 8000);

// Passport session setup.
passport.serializeUser(function(user, done) {
  done(null, user);
});
passport.deserializeUser(function(obj, done) {
  done(null, obj);
});

app.use(bodyParser.urlencoded({ keepExtensions:true }));
app.use(cookieParser());
app.use(cookieSession({
    secret: 'I love stackoverflow',
    cookie: { maxage: 60000 } // 1 minute : this isn't working.
}));

app.use(express.static('app/public'));
app.use(passport.initialize());
app.use(passport.session());


// app.use('/', routes);
// app.use('/session', session);

app.use(function(req, res, next) { // Set global app variable
  if (res.locals) {
    res.locals.user = req.session.passport.user; // pass session user to all templates
  }
  next();
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
  profileFields: ['id', 'displayName', 'photos', 'email', 'profileUrl', 'first_name', 'last_name', 'education', 'accounts'],
  passReqToCallback: true
}, function(req, accessToken, refreshToken, profile, done) {
  req.session.fbAccessToken = profile._json.accounts.data[0].access_token;
  req.session.fbGroups = profile._json.accounts.data;
  var currUser;
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
          currUser = newUser;
        });
      } else {
        console.log('>> Found user. Redirecting to ' + profile.id);
        currUser = user;
      }
    }).then(function() {
      req.user = currUser;
      return done(null, currUser);
    });
  });
}));

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
  if (req.session && req.session.user) {
    req.session.user = null;
  }
  res.redirect('/');
});

require('./app/controllers')(app); // Allow for Routing
app.listen(app.get('port')); //starts up the server
console.log('Server running on port', app.get('port'));
