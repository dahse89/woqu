module.exports = class Next

  constructor: (@master, @args) ->

  init: ->
    @moveCurTaskBackwards()

  ###*
  * update Task to increase postponed
  ###
  moveCurTaskBackwards: () ->
    [todo,IO,msg] = @master.factory('cmd/todo','IO','config/messages.noTaskOpen')

    todo.getCurrentTask (task) ->
      if task is null
        IO.println msg
        process.exit()
      else
        task.increment('postponed').then () ->
          todo.init()

module.exports = Next