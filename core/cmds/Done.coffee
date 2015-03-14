module.exports = class Done

  constructor: (@master, @args) ->

  init: -> @setDone()

  ###*
  * set current Task to done and print it
  ###
  setDone: () ->
    IO = @master.factory("IO")
    todo = @master.woqu('todo')
    todo.getCurrentTask (task)->

        attr = done_at: new Date()
        where = where: id: task.getDataValue("id")

        task.update(attr, where)
          .then () ->
            IO.printTask(task)
            todo.init()
          .catch (err) ->
            console.log err


module.exports = Done
