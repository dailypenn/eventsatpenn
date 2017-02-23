"use strict";
module.exports = function(sequelize, DataTypes) {
  var PlannedEvent = sequelize.define("Event", {
    title: DataTypes.STRING,
    start_time: DataTypes.DATE,
    end_time: DataTypes.DATE,
    description: DataTypes.TEXT,
    location: DataTypes.TEXT,
    category: DataTypes.ENUM,
    twentyoneplus: DataTypes.BOOLEAN,
    recurring: DataTypes.BOOLEAN,
    recurrence_freq: DataTypes.ENUM,
    recurrence_amt: DataTypes.INTEGER,
  });

  return PlannedEvent;
};
