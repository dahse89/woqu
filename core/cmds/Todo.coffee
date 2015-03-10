Todo = do ->
  # privates
  Task = require '../model/Task.js'
  db = null
  IO = null
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
    [db, IO] = master.coreModels "db","IO"
    Todo.getTodo()

  ###*
  * get current Task from database
  ###
  getTodo: (task) ->
    db.init (db)->
      db.getCurrentTask (task)->
        IO.println task.toString()
        process.exit()
module.exports = Todo