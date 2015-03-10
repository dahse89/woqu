Todo = do ->
  # privates
  Task = require '../model/Task.js'
  db = null
  master = null
  args = null

  # public

  ###*
  * init Todo model, args are passed
  * to receive model options
  * @param _args array
  * @param _db Db_ref
  * @param _master WoQu_ref
  ###
  init: (_args,_master) ->
    args = _args
    master = _master
    db = master.getDb()
    Todo.getTodo()

  ###*
  * get current Task from database
  ###
  getTodo: (task) ->
    db.init (db)->
      db.getCurrentTask (task)->
        console.log(task.toString())

module.exports = Todo