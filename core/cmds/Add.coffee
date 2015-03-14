module.exports = class Add

  constructor: (@master, @args) ->
    [@db,@IO] = @master.coreModels("db","IO")

  init: ->
    if @args.length is 0
      @IO.readLine "Description: ", (answer, IO) ->
        # todo save to db
        IO.println "Thank you for your valuable feedback:#{answer}"
      return;
    if @args.length is 1
      @addTask(@args[0])

  ###*
  * add a Task to database
  ###
  addTask: (description) ->
    IO = @IO
    task = @db.getModel('Task').build(
      description: description,
      poststponed: 0
    )

    task.save()
      .catch IO.error
      .then (task) ->
       IO.println("Add Task: ##{task.getDataValue('id')}")
       process.exit()


module.exports = Add