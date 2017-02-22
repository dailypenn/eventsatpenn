"use strict";
module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("User", {
    pennKey: { type: DataTypes.STRING /*, primaryKey: true */}, // If we get access to pennkeys, this will be the PK, but can't as of now.
    firstName: DataTypes.STRING,
    lastName: DataTypes.STRING,
    email: DataTypes.STRING,
    student: DataTypes.BOOLEAN,
    faculty: DataTypes.BOOLEAN,
    fbID: DataTypes.STRING
  });

  return User;
};
