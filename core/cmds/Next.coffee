module.exports = class Next

  constructor: (@master, @args) ->

  init: ->
    @moveCurTaskBackwards()

  ###*
  * update Task to increase postponed
  ###
  moveCurTaskBackwards: () ->
    todo = @master.factory('cmd/todo')

    todo.getCurrentTask (task) ->
      postponed = task.getDataValue("postponed")
      task.updateAttributes(postponed:postponed+1).then () -> todo.init()

module.exports = Next