WoQu = do ->
  # privates
  db = require './Db.js'
  Task = require './model/Task.js'
  args = null
  subCommandsDir = './'

  #public
  ###*
  * start woqu app and handle args
  ###
  run: ->
    args = WoQu.getArgs()
    model = WoQu.toCoreModelName(args[0])
    return require(
      subCommandsDir + model
    ).init(args.slice(1),db,WoQu)

  ###*
  * ensure that sub comment is in model name format
  * (first char uppercase )
  ###
  toCoreModelName: (str) ->
    str += ''
    f = str.charAt(0).toUpperCase()
    f + str.substr(1).toLowerCase()

  ###*
  * get relevant args
  * @return array
  ###
  getArgs: -> process.argv.slice(2)

  ###*
  * get database model reference
  * @return Db_ref
  ###
  getDb: -> db

module.exports = WoQu