"use strict";
module.exports = function(sequelize, DataTypes) {
  var OrgEvent = sequelize.define('OrgEvent', {
    org_id: DataTypes.INTEGER,
    event_id: DataTypes.INTEGER,
    fbPage: DataTypes.STRING
  });
  return OrgEvent;
};
