module.exports = class Done

  constructor: (@master, @args) ->

  init: -> @setDone()

  ###*
  * set current Task to done and print it
  ###
  setDone: () ->
    [IO,todo,msg] = @master.factory(
      "IO", "cmd/todo", "config/messages.noTaskOpen"
    )

    todo.getCurrentTask (task)->
        if task is null
          IO.println msg
          process.exit()
        else
          attr = done_at: new Date()
          where = where: id: task.id

          task.update(attr, where)
            .then () ->
              IO.printTask task, -> todo.init()
            .catch (err) ->
              console.log err


module.exports = Done
