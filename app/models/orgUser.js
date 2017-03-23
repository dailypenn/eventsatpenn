"use strict";
module.exports = function(sequelize, DataTypes) {
  var OrgUser = sequelize.define('OrgUser', {
    user_id: DataTypes.INTEGER,
    org_id: DataTypes.INTEGER,
    isAdmin: DataTypes.BOOLEAN,
  });
  return OrgUser;
};
