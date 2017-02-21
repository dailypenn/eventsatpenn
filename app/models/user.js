// constructor
function User(fName, lName, fbID) {
  this.fName = fName;
  this.lName = lName;
  this.fbID = fbID;
}

User.prototype.fullName = function() {
  return this.fName + ' ' + this.lName;
};

module.exports = User;
