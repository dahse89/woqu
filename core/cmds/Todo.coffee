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
    Task = @master.getTask()
    db = new @db(@master)
    db.init (orm,models)->
      models.Task.find(
        where: ["done_at is not null"]
        order: [
          ["(task_id+postponed)","ASC"],
          ["postponed","ASC"],
          ["task_id","ASC"],
        ]
        limit: 1
      ).then (res)->
        console.log(res)


module.exports = Todo

###
      SELECT
      id,
      description,
      created_at,
      postponed,
      done_at
    FROM tasks
    WHERE done_at IS NULL
    ORDER by (id+postponed),postponed,id ASC
    LIMIT 1
###