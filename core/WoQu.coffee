WoQu = do ->
  # privates
  db   = require './Db.js'
  Task = require './model/Task.js'
  fs   = require 'fs'
  clicolor = require 'cli-color'

  args = null
  subCommandsDir = './'
  coreDir = './core/'
  devMode = true

  #public
  ###*
  * start woqu app and handle args
  ###
  run: (_devMode) ->
    devMode = _devMode
    args = WoQu.getArgs()
    WoQu.getModel(args[0]).init(args.slice(1),WoQu)

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
    path = coreDir + model + '.js'
    requirePath = subCommandsDir + model
    if fs.existsSync(path) then require(requirePath) else init: ->
      console.error "invalid command: #{str}"

  ###*
  * check if app is in development mode
  * @return boolean
  ###
  isDevMode: -> devMode

  ###*
  * cli color handle getter
  * @return cli-color_ref
  ###
  getCliColor: -> clicolor


module.exports = WoQu