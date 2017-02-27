"use strict";
module.exports = function(sequelize, DataTypes) {
  var models = require("./index.js");

  var User = sequelize.define("User", {
    firstName: DataTypes.STRING,
    lastName: DataTypes.STRING,
    email: DataTypes.STRING,
    fbID: DataTypes.STRING
  }, {
    classMethods: {
      associate: function(models) {
        User.belongsToMany(models.Org, {through: 'OrgUser', foreignKey: 'user_id'});
      }
    }
  });

  return User;
};
