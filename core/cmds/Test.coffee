module.exports = class Test

  constructor: (@master, @args) ->

  ###*
  * test function
  ###
  init: () ->
    console.log("do tests here")
    host = @master.factory('config/database')
    console.log(host)


