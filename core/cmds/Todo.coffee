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

    IO = @master.factory('IO')
    @getCurrentTask (task) ->
      IO.printTask(task)
      #process.exit()

