module.exports = class Add

  constructor: (@master, @args) ->

  init: ->
    [IO,descMsg,addTaskMsg] = @master.factory(
      'IO','config/messages.description'
      'config/messages.addTask'
    )
    if @args.length is 0
      IO.readLine descMsg + ": ", (answer, IO) ->
        # todo save to db
        IO.println addTaskMsg + answer
      return;
    if @args.length is 1
      @addTask(@args[0])

  ###*
  * add a Task to database
  ###
  addTask: (description) ->
    [IO,Task,addTaskMsg] = @master.factory(
      'IO','model/Task', 'config/messages.addTask'
    )
    task = Task.build(
      description: description,
      poststponed: 0
    )

    task.save()
      .catch IO.error
      .then (task) ->
       IO.println(addTaskMsg + task.id)
       process.exit()


module.exports = Add