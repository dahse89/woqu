module.exports = class Next

  constructor: (@master, @args) ->

  init: ->
    @db = @master.getDb()
    @moveCurTaskBackwards()

  ###*
  * update Task to increase postponed
  ###
  moveCurTaskBackwards: (task) ->
    master = @master
    @db.init (db)->
      db.getCurrentTask (task) ->
        task.increasePostponed()
        db.updateTask task,()->
          todo = master.factory().get(master,'todo')
          todo.init()

module.exports = Next