"use strict";
module.exports = function(sequelize, DataTypes) {
  var models = require("./index.js");

  var User = sequelize.define("User", {
    id: { type: DataTypes.INTEGER, primaryKey: true },
    firstName: DataTypes.STRING,
    lastName: DataTypes.STRING,
    displayName: DataTypes.STRING,
    email: DataTypes.STRING
  }, {
    classMethods: {
      associate: function(models) {
        User.belongsToMany(models.Org, {through: 'OrgUser', foreignKey: 'user_id'});
      },
      login: function(passport) {


      }
    }
  });

  return User;
};
