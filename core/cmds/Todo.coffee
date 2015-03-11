module.exports = class Todo

  constructor: (@master, @args) ->

  init: () ->
    [@db, @IO] = @master.coreModels "db","IO"
    @getTodo()

  ###*
  * get current Task from database
  ###
  getTodo: () ->
    IO = @IO
    @db.init (db)->
      db.getCurrentTask (task)->
        IO.println task.toString()
        process.exit()

module.exports = Todo