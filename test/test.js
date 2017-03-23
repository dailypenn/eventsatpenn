var assert = require('assert');

describe('Model Tests', function () {
  describe('User', function () {
    var tests = require('./models/user-tests.js');
    it('should always pass', tests.testAssertion);
    it('User should create without error', tests.userCreates);
  });
});
