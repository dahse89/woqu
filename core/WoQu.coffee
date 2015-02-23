WoQu = do ->
  # privates
  db   = require './Db.js'
  Task = require './model/Task.js'
  fs   = require 'fs'

  args = null
  subCommandsDir = './'

  #public
  ###*
  * start woqu app and handle args
  ###
  run: ->
    args = WoQu.getArgs()
    WoQu.getModel(args[0]).init(args.slice(1),db,WoQu)

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

  ###*
  * get sub model
  * @return subModel_ref
  ###
  getModel: (str) ->
    model = WoQu.toCoreModelName(str)
    path = subCommandsDir + model + '.js'
    if fs.existsSync(path) then require(path) else init: ->
      console.error "invalid command: #{str}"

module.exports = WoQu