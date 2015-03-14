module.exports = class Admin

  constructor: (@master, @args) ->

  ###*
  * admin actions function
  ###
  init: () ->
    if @args[0] is 'dbUpdate'
      db = @master.factory('db');
      db.updateDbSchema(true)

    if @args[0] is 'dbInstall'
      db = @master.factory('db');
      db.updateDbSchema(false)


