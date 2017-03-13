"use strict";
module.exports = function(sequelize, DataTypes) {
  var models = require("./index.js");

  var Org = sequelize.define("Org", {
    name: DataTypes.STRING,
    tagline: DataTypes.STRING,
    bio: DataTypes.STRING,
    fbID: DataTypes.INTEGER,
    fbUsername: DataTypes.STRING,
    category: DataTypes.STRING,
    website: DataTypes.STRING,
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
