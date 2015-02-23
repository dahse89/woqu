db = require './Db.js'
Task = require './model/Task.js'
Add = require './Add.js'

WoQu =
  Task: null,
  args: null,

  run: ->
    WoQu.args = WoQu.getArgs()
    if(WoQu.args[0] is 'add')
      return Add.init(WoQu.args.slice(1))
    else if(WoQu.args.length is 1 and WoQu.args[0] is 'todo')
      return WoQu.getTodo()
    else if(WoQu.args.length is 1 and WoQu.args[0] is 'done')
      return WoQu.setCurrentDone()
    else if(WoQu.args.length is 1 and WoQu.args[0] is 'next')
      return WoQu.nextFirst()
    console.error("Invalid command")

  getArgs: -> process.argv.slice(2)

  getDb: -> db

  nextFirst: () ->
    WoQu.getDb().init (db)->
      db.getCurrentTask (task) ->
        task.increasePostponed()
        db.updateTask task,WoQu.getTodo

  setCurrentDone: () ->
    WoQu.getDb().init (db)->
      db.getCurrentTask (task) ->
        task.setDoneAt(new Date())
        db.updateTask task,()->
          console.log(task.toString())

  getTodo: () ->
    WoQu.getDb().init (db)->
      db.getCurrentTask (task)->
        console.log(task.toString())


module.exports = WoQu