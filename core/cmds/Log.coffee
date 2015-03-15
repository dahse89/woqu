module.exports = class Log

  constructor: (@master, @args) ->

  init: -> @logInfo()

  ###*
  * set current Task to done and print it
  ###
  logInfo: () ->
    [todo,LoggedWork,IO] = @master.factory('cmd/todo','model/LoggedWork','IO')
    text = @args[0]
    todo.getCurrentTask (task) ->
      if task is null
        IO.println "Currently there is no task open"
        process.exit()
      else
        work = LoggedWork.build text: text
        work.save()
          .catch IO.error
          .then ->
            task.addLoggedWork(work).then ->
              todo.init()




module.exports = Log
