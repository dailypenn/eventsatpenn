var FB       = require('fb');
var authConfig = require('../config/auth.js');

FB.options({
  appId:          authConfig.facebookAuth.clientID,
  appSecret:      authConfig.facebookAuth.clientSecret,
  redirectUri:    authConfig.facebookAuth.callbackURL
});

var getAllUserPages = function(fbID, accessToken) {
  return new Promise(function(resolve, reject) {
    FB.api(fbID + '/accounts', {
        access_token:   accessToken,
        limit: 25
    }, function (result) {
      if(!result || result.error) {
        console.error(result.error || "no result returned.");
        reject(result.error || "no result returned.")
      }
      resolve(result);
    });
  });
};

var getPageDetails = function(pageID, accessToken) {
  return new Promise(function(resolve, reject) {
    FB.api(`/${pageID}`, {
        access_token:   accessToken,
        fields: ['name', 'about', 'description', 'category', 'link', 'username', 'website']
    }, function (result) {
      resolve(result);
    });
    reject('Error: unknown');
  });
}

module.exports = function(app){
  var Org = require('../models').Org;
  var User = require('../models').User;

  var UserController = require('./userController.js');

  app.get('/org', function(req, res) {
    Org.sync();
    Org.findAll().then(function(orgs) {
      res.render('orgs/all.jinja', {orgs: orgs});
    })
  });

  app.post('/org', function(req, res) {
    console.log(`>> Creating org ${req.body.name} with fbID ${req.body.id}`);
    console.log(req.body);
    Org.create({
      name: req.body.name,
      tagline: req.body.tagline,
      bio: req.body.bio,
      fbID: req.body.fbID,
      fbURL: req.body.fbURL,
      category: req.body.category,
      website: req.body.website,
      photo: req.body.photo
    }).then(function(newOrg) {
      console.log(`>> Successfully created org ${newOrg.get('name')}`);

      newOrg.addUser(req.user.id).then(function(){
        res.redirect('/org/' + newOrg.id);
      });
    });
  });

  app.get('/org/new', function(req, res) {
    if (!req.user) {
      res.redirect('/');
    }
    var accessToken = req.user._json.accounts.data[0].access_token;
    var pageData = [];
    // TODO: Fix this callback hell
    getAllUserPages(req.user.id, accessToken).then(function(userPages) {
      userPages.data.forEach(function(page) {
        FB.api(`/${page.id}`, {
            access_token:   accessToken,
            fields: ['name', 'about', 'description', 'category', 'link', 'username', 'website']
        }, function (result) {
          pageData.push(result);
          if (pageData.length == userPages.data.length) {
            res.render('orgs/new.jinja', {pages: pageData});
          }
        });
      });
    });
  });

  app.get('/org/view', function(req, res) {
    res.render('orgs/view.jinja', {});
  });

  app.get('/org/fbdetails/:fbID', function(req, res) {
    var accessToken = req.user._json.accounts.data[0].access_token;
    FB.api(`/${req.params.fbID}`, {
        access_token:   accessToken,
        fields: ['name', 'about', 'description', 'category', 'link', 'username', 'website', 'picture.height(512)']
    }, function (result) {
      res.send(result);
    });
  });

  app.get('/org/:id', function(req, res) {
    Org.findOne({
      where: {
        id: req.params.id
      }
    }).then(function(org) {
      org.getUsers().then(function(admins) {
        res.render('orgs/view.jinja', {org: org, admins: admins})
      })
    });
  })
};
