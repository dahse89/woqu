module.exports = class Todo

  constructor: (@master, @args) ->

  init: -> @getTodo()

  getCurrentTask: (cb) ->
    @master.factory('model/Task').find(
      where: ["done_at is null"]
      order: 'id + postponed, postponed, id ASC'
      limit: 1
    ).then cb


  ###*
  * get current Task from database
  ###
  getTodo: () ->

    [IO, msg] = @master.factory('IO','config/messages.nothingTodo')
    @getCurrentTask (task) ->
      if task is null
        IO.println(msg);
        process.exit();
      else
        IO.printTask task, ->
          process.exit()

