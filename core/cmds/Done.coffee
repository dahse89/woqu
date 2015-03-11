module.exports = class Done

  constructor: (@master, @args) ->

  init: ->

    [@IO,@db] = @master.coreModels "IO", "db"
    @setDone()

  ###*
  * set current Task to done and print it
  ###
  setDone: () ->
    IO = @IO
    @db.init (db)->
      db.getCurrentTask (task) ->
        task.setDoneAt(new Date())
        db.updateTask task,()->
          IO.println task.toString()
          process.exit();

module.exports = Done