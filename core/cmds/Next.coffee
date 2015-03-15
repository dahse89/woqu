module.exports = class Next

  constructor: (@master, @args) ->

  init: ->
    @moveCurTaskBackwards()

  ###*
  * update Task to increase postponed
  ###
  moveCurTaskBackwards: () ->
    [todo,IO] = @master.factory('cmd/todo','IO')

    todo.getCurrentTask (task) ->
      if task is null
        IO.println "Currently there is no task open"
        process.exit()
      else
        task.increment('postponed').then () ->
          todo.init()

module.exports = Next