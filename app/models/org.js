"use strict";
module.exports = function(sequelize, DataTypes) {
  var models = require("./index.js");

  var Org = sequelize.define("Org", {
    name: DataTypes.STRING,
    website: DataTypes.STRING,
    fbID: DataTypes.STRING,
    isPublic: DataTypes.BOOLEAN
  }, {
    classMethods: {
      associate: function(models) {
        Org.belongsToMany(models.User, {through: 'OrgUser',  foreignKey: 'org_id'});
        // Org.hasMany(models.Event, {through: 'OrgEvent',  foreignKey: 'org_id'});
      }
    }
  });

  return Org;
};
