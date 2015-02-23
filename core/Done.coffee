Done = do ->
  # privates
  Task = require './model/Task.js'
  db = null
  master = null
  args = null

  # public

  ###*
  * init Done model, args are passed
  * to receive model options
  * @param _args array
  * @param _db Db_ref
  * @param _master WoQu_ref
  ###
  init: (_args,_db,_master) ->
    args = _args
    db = _db
    master = _master
    Done.setDone()

  ###*
  * set current Task to done and print it
  ###
  setDone: (task) ->
    db.init (db)->
    db.getCurrentTask (task) ->
      task.setDoneAt(new Date())
      db.updateTask task,()->
        console.log(task.toString())

module.exports = Done