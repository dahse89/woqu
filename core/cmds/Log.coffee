module.exports = class Log

  constructor: (@master, @args) ->
    [@IO,@db] = @master.factory "IO", "db"

  init: -> @logInfo()

  ###*
  * set current Task to done and print it
  ###
  logInfo: () ->

    @IO.println("jf lösjfl ajsfjlöasj fl")


module.exports = Log
