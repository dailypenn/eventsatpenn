"use strict";
module.exports = function(sequelize, DataTypes) {
  var Org = require("./org.js")(sequelize, DataTypes);
  var User = sequelize.define("User", {
    firstName: DataTypes.STRING,
    lastName: DataTypes.STRING,
    email: DataTypes.STRING,
    fbID: DataTypes.STRING
  });

  User.belongsToMany(Org, {through: "OrgAdmin", foreignKey: "id"});
  Org.belongsToMany(User, {through: "OrgAdmin", foreignKey: "id"});

  return User;
};
