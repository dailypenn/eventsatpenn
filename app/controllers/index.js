/**
 * index.js
 * @file Recursively requires all files in the controllers directory, passing
 * them the app object so that routes can be resolved.
 * @author Andrew Fischer <afischer15@mac.com>
 */

module.exports = function(app) {
  var requireDirectory = require('require-directory'),
    visitor = function(controller) {
      controller(app)
    },
    hash = requireDirectory(module, {visit: visitor});;
};
