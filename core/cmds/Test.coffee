module.exports = class Test

  constructor: (@master, @args) ->

  ###*
  * test function
  ###
  init: () ->
    console.log("do tests here")

    task = @master.getDb().getModel('Task').build()
    task.description = "mal wieder ein test"
    task.postponed = 0
    task.test = "will this new field be added"

    task.save()
        .catch (err) -> console.log(err)
        .then (task) -> console.log("success " + task.getDataValue("id"))

    ###
    task.description = "new sequelize test"
    task.postponed = 0
    task.done_at = null

    task.save()
      .catch (err) -> console.log(err)
      .then (task) -> console.log("success " + task.getDataValue("id"))
    ###



