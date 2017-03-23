var clc = require("cli-color");
var logColors = {
  log: clc.green,
  info: clc.blue,
  warn: clc.yellow,
  error: clc.red.bold,
};

function dateStr(date) {
  var hour = date.getHours();
  var minutes = date.getMinutes();
  var seconds = date.getSeconds();
  var milliseconds = date.getMilliseconds();

  return '[' + ((hour < 10) ? '0' + hour: hour) + ':' +
  ((minutes < 10) ? '0' + minutes: minutes) + ':' +
  ((seconds < 10) ? '0' + seconds: seconds) + '.' +
  ('00' + milliseconds).slice(-3) + '] ';
}

["log", "info", "warn", "error"].forEach(function(method) {
  var oldMethod = console[method].bind(console);
  console[method] = function() {
    var firstParam = arguments[0];
    var otherParams = Array.prototype.slice.call(arguments, 1);
    var now = new Date();
    var prefix = logColors[method](`${method.toUpperCase()}: ${dateStr(now)}`);
    oldMethod.apply(console, [prefix + firstParam].concat(otherParams));
  };
});
