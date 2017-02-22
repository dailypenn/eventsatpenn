"use strict";
module.exports = function(sequelize, DataTypes) {
  var Org = sequelize.define("Org", {
    name: DataTypes.STRING,
    website: DataTypes.STRING,
    fbPage: DataTypes.STRING
  });

  return Org;
};
