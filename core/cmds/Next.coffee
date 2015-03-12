module.exports = class Next

  constructor: (@master, @args) ->

  init: ->
    @db = @master.getDb()
    @moveCurTaskBackwards()

  ###*
  * update Task to increase postponed
  ###
  moveCurTaskBackwards: () ->
    todo = @master.factory('todo')

    todo.getCurrentTask (task) ->
      postponed = parseInt(task.getDataValue("postponed"));
      task.updateAttributes( postponed: postponed+1).then () -> todo.init()

module.exports = Next