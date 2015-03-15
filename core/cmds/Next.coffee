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
      task.increment('postponed').then () ->
        todo.init()

module.exports = Next