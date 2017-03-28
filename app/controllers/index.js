/**
 * index.js
 * @file Recursively requires all files in the controllers directory, passing
 * them the app object so that routes can be resolved. Also allows parsing of
 * x-www-form-urlencoded
 * @author Andrew Fischer <afischer15@mac.com>
 */

module.exports = function(app) {
  var requireDirectory = require('require-directory');
  var bodyParser = require('body-parser');

  app.use(bodyParser.urlencoded({ extended: true }));
  app.use(bodyParser.json());

  // pass the app variable to all modules in directory on recursive visit
  var passApp = function(controller) {controller(app)};
  requireDirectory(module, {visit: passApp});
};

