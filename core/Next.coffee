Next = do ->
  # privates
  Task = require './model/Task.js'
  db = null
  master = null
  args = null

  # public

  ###*
    * init Next model, args are passed
    * to receive model options
    * @param _args array
    * @param _db Db_ref
    * @param _master WoQu_ref
  ###
  init: (_args,_db,_master) ->
    args = _args
    db = _db
    master = _master
    Next.moveCurTaskBackwards()

  ###*
  * update Task to increase postponed
  * run woqu todo
  ###
  moveCurTaskBackwards: (task) ->
    db.init (db)->
      db.getCurrentTask (task) ->
        task.increasePostponed()
        db.updateTask task,master.getTodo

module.exports = Next