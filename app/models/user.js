"use strict";
module.exports = function(sequelize, DataTypes) {
  var models = require("./index.js");

  var User = sequelize.define("User", {
    firstName:   DataTypes.STRING,
    lastName:    DataTypes.STRING,
    displayName: DataTypes.STRING,
    email:       DataTypes.STRING,
    photoURL:    DataTypes.STRING,
    fbLink:      DataTypes.STRING,
    fbId:        DataTypes.STRING
  }, {
    getterMethods : {
      fullName : function() { return this.firstName + ' ' + this.lastName }

    }, classMethods: {
      associate: function(models) {
        User.belongsToMany(models.Org, {through: 'OrgUser', foreignKey: 'user_id'});
      }
    }
  });
  return User;
};
