"use strict";
module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("User", {
    pennKey: { type: DataTypes.STRING, primaryKey: true},
    firstName: DataTypes.STRING,
    lastName: DataTypes.STRING,
    student: DataTypes.BOOLEAN,
    faculty: DataTypes.BOOLEAN,
    fbID: DataTypes.STRING
  });

  return User;
};
