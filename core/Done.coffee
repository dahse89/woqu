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
  init: (_args,_master) ->
    args = _args
    master = _master
    db = master.getDb()
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