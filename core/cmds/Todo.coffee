module.exports = class Todo

  constructor: (@master, @args) ->
    [@db, @IO] = @master.coreModels "db","IO"

  init: -> @getTodo()

  getCurrentTask: (cb) ->
    @master.getDb().getModels().Task.find(
      where: ["done_at is null"]
      order: 'id + postponed, postponed, id ASC'
      limit: 1
    ).then cb



  ###*
  * get current Task from database
  ###
  getTodo: () ->
    IO = @IO
    Task = @master.getTask()
    @getCurrentTask (res) ->
      task = new Task(res);

      IO.println(task.toString())
      process.exit()



module.exports = Todo
