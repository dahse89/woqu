module.exports = class Info

  constructor: (@master, @args) ->

  init: -> @addInfo()

  ###*
  * set current Task to done and print it
  ###
  addInfo: () ->
    [todo,Info,IO,msg] = @master.factory(
      'cmd/todo','model/Info','IO',
      'config/messages.noTaskOpen'
    )
    text = @args[0]
    todo.getCurrentTask (task) ->
      if task is null
        IO.println msg
        process.exit()
      else
        info = Info.build text: text
        info.save()
          .catch IO.error
          .then ->
            task.addInfo(info).then ->
              todo.init()
