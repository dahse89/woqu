module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Task',
      description: DataTypes.TEXT
      postponed: type: DataTypes.INTEGER, allowNull: false, defaultValue: 0
      done_at: DataTypes.DATE
    ,
    instanceMethods:
      postpone: ->
        postponeVal = @getDataValue('postponed')
        postponeVal = 0 if typeof postponeVal is 'undefined'
        postponeVal++;
        @setDataValue("postponed",postponeVal)
    ,
    classMethods: {}
