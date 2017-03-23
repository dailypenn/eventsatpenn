var assert = require('assert');
var User = require('../../app/models/index.js').User;

exports.userCreates = function() {
  User.create({
    id: 1234,
    firstName: 'Carter',
    lastName: 'Coudriet',
    email: 'coudriet@thedp.com'
  }).then(function(newUser) {
    assert.typeOf(newUser, 'object');
    assert.equal(newUser.get('firstName'), 'Carter');
    assert.equal(newUser.get('lastName'), 'Coudriet')
    assert.equal(newUser.get('email'), 'coudriet@thedp.com')
  });
}

exports.testAssertion = function() {
  assert.equal(25, 25);
}
