db = require './Db.js'
Task = require './model/Task.js'

Add =
  args: null,

  init: (args) ->
    Add.args = args
    if Add.args.length is 1
      task = new Task()
      task.setDescription(Add.args[0])
      task.setCreatedAt(new Date())
      task.setPostponed(0)
      Add.addTask(task)

  addTask: (task) ->
    db.init (db) ->
      db.insertTask task, ->
        task.setId(@.lastID)
        console.log "Task ##{task.getId()} added"

module.exports = Add