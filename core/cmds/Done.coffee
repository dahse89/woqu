module.exports = class Done

  constructor: (@master, @args) ->
    [@IO,@db] = @master.coreModels "IO", "db"

  init: -> @setDone()

  ###*
  * set current Task to done and print it
  ###
  setDone: () ->
    IO = @IO
    todo = @master.factory('todo')
    todo.getCurrentTask (task)->

        attr = done_at: new Date()
        where = where: id: task.getDataValue("id")

        task.update(attr, where)
          .then () ->
            IO.printTaskOrmModel(task)
            todo.init()
          .catch (err) ->
            console.log err


module.exports = Done
