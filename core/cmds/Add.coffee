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
      Task = @master.getTask()
      task = new Task()
      task.setDescription(@args[0])
      task.setCreatedAt(new Date())
      task.setPostponed(0)
      @addTask task, -> process.exit()

  ###*
  * add a Task to database
  ###
  addTask: (task,cb) ->
    IO = @IO
    Task = @master.getTask()

    @db.getModels().Task.create(task).then (res) ->
      task.fromOrm(res)
      IO.println("Add Task: ##{task.getId()}")
      cb()

module.exports = Add