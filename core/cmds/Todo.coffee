module.exports = class Todo

  constructor: (@master, @args) ->
    [@db, @IO] = @master.coreModels "db","IO"

  init: -> @getTodo()

  getCurrentTask: (cb) ->
    @db.getModel('Task').find(
      where: ["done_at is null"]
      order: 'id + postponed, postponed, id ASC'
      limit: 1
    ).then cb

  ###*
  * get current Task from database
  ###
  getTodo: () ->

    IO = @IO
    @getCurrentTask (task) ->
      IO.printTask(task)
      process.exit()

module.exports = Todo
