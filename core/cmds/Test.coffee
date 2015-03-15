module.exports = class Test

  constructor: (@master, @args) ->

  ###*
  * test function
  ###
  init: () ->
    console.log("do tests here")
    cfg = @master.factory('config')
    console.log cfg.getImpl


