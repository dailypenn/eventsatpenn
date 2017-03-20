var User   = require('../models').User;
var passport = require('passport');
var FacebookStrategy = require('passport-facebook').Strategy
var FB       = require('fb');
var authConfig = require(__base + 'config/auth.js');

FB.options({
  appId:          authConfig.facebookAuth.clientID,
  appSecret:      authConfig.facebookAuth.clientSecret,
  redirectUri:    authConfig.facebookAuth.callbackURL
});

// Passport session setup.
passport.serializeUser(function(user, done) {
  done(null, user);
});
passport.deserializeUser(function(obj, done) {
  done(null, obj);
});

// Facebook Strategy
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
    User.findOne({ where: { id: profile.id }}).then(function(user) {
      if (!user) {
        console.log('>> New User! Creating ' + profile.id);
        User.create({
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

module.exports = function(app){
  // Initialize Passport with express
  app.use(passport.initialize());
  app.use(passport.session());

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
};
