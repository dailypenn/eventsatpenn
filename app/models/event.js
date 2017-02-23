"use strict";
module.exports = function(sequelize, DataTypes) {
  var config       = require(__dirname + '/../config/eventConfig.js');
  var PlannedEvent = sequelize.define("Event", {
    title: DataTypes.STRING,
    start_time: DataTypes.DATE,
    end_time: DataTypes.DATE,
    description: DataTypes.TEXT,
    location: DataTypes.TEXT,
    category: DataTypes.ENUM(config.categories),
    twentyoneplus: DataTypes.BOOLEAN,
    recurring: DataTypes.BOOLEAN,
    recurrence_freq: DataTypes.ENUM(config.recFreqs),
    recurrence_amt: DataTypes.INTEGER,
  });

  return PlannedEvent;
};
