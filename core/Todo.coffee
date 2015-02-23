Todo = do ->
  # privates
  Task = require './model/Task.js'
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
  init: (_args,_db,_master) ->
    args = _args
    db = _db
    master = _master
    Todo.getTodo()

  ###*
  * get current Task from database
  ###
  getTodo: (task) ->
    db.init (db)->
      db.getCurrentTask (task)->
        console.log(task.toString())

module.exports = Todo