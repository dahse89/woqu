module.exports = class Test

  constructor: (@master, @args) ->

  ###*
  * test function
  ###
  init: () ->
    console.log("do tests here")
    [Task,LoggedWork,IO] = @master.factory 'model/Task', 'model/LoggedWork', 'IO'

    ###
    Task.find( where: ['id = 1'], limit: 1).then (task) ->
      work = LoggedWork.build text: "njklxnasjknxl asnx "
      work.save().catch(IO.error).then ->
        task.addLoggedWork(work).then -> console.log "done"
    ###

    Task.find( where: ['id = 1'], limit: 1).then (task) ->
      console.log task.id
      task.getLoggedWorks().then (works) ->
         works.forEach (work) -> console.log work.text


