"use strict";
module.exports = function(sequelize, DataTypes) {
  var models = require("./index.js");

  var Org = sequelize.define("Org", {
    name: DataTypes.STRING,
    website: DataTypes.STRING,
    fbPage: DataTypes.STRING
  }, {
    classMethods: {
      associate: function(models) {
        Org.belongsToMany(models.User, {through: 'OrgUser',  foreignKey: 'org_id'});
      }
    }
  });

  return Org;
};
