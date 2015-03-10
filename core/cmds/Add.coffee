# todo make a new class for stdin/out

Add = do ->
  # privates
  Task = require '../model/Task.js'

  db = null
  master = null
  args = null

  # public

  ###*
  * init Add model, args are passed
  * to receive model options
  * @param _args array
  * @param _db Db_ref
  * @param _master WoQu_ref
  ###
  init: (_args,_master) ->
    args = _args
    master = _master
    [db,IO] = master.coreModels("db","IO")
    if args.length is 0
      IO.readLine "Description: ", (answer) ->
        # todo save to db
        IO.println "Thank you for your valuable feedback:#{answer}"
      return;
    if args.length is 1
      task = new Task()
      task.setDescription(args[0])
      task.setCreatedAt(new Date())
      task.setPostponed(0)
      Add.addTask task, -> process.exit()


  ###*
  * add a Task to database
  ###
  addTask: (task,cb) ->
    db.init (db) ->
      db.insertTask task, ->
        task.setId(@.lastID)
        console.log "Task ##{task.getId()} added"
        cb()

module.exports = Add