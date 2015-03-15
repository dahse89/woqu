module.exports = class Test

  constructor: (@master, @args) ->

  ###*
  * test function
  ###
  init: () ->
    console.log("do tests here")
    [Task,LoggedWork,Info] = @master.factory(
      'model/Task','model/LoggedWork',
      'model/Info'
    )
    Task.findAll(
      where: id: 1
      include:[
        Info
        LoggedWork
      ]
    ).then (fulltask) ->
      fulltask[0].Infos.forEach (info) ->
        console.log info.text

      fulltask[0].LoggedWorks.forEach (work) ->
        console.log work.text




