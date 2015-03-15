module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Info',
      text: DataTypes.TEXT
    ,
    instanceMethods: {}
    ,
    classMethods: {}
