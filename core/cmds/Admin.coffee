module.exports = class Admin

  constructor: (@master, @args) ->

  ###*
  * admin actions function
  ###
  init: () ->
    if @args[0] is 'dbUpdate'
      db = @master.getDb();
      db.updateDbSchema(true)

    if @args[0] is 'dbInstall'
      db = @master.getDb();
      db.updateDbSchema(false)


