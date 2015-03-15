module.exports = (sequelize, DataTypes) ->
  sequelize.define 'LoggedWork',
      text: DataTypes.TEXT
    ,
    instanceMethods: {}
    ,
    classMethods: {}
