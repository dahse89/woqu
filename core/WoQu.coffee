WoQu = do ->
  # privates
  db   = require './Db.js'
  Task = require './model/Task.js'
  fs   = require 'fs'
  clicolor = require 'cli-color'
  IO = require './IO.js'
  CmdsFactory = require './CmdsFactory.js'

  args = null
  devMode = true

  #public
  ###*
  * start woqu app and handle args
  ###
  run: (_devMode) ->
    devMode = _devMode
    args = WoQu.getArgs()
    cmd = CmdsFactory.get(WoQu,args[0],args.slice(1))
    cmd.init()

    #WoQu.getModel(args[0]).init(args.slice(1),WoQu)


  factory: -> CmdsFactory

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
  * get IO model reference
  * @return IO_ref
  ###
  getIO: -> IO

  ###*
  * get Task class
  * @return Task
  ###
  getTask: -> Task

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

  ###*
  # inline Model Getter
  ###
  coreModels: (names...)->
    models = []
    for i,name of names
      models.push(db) if (name is 'db')
      models.push(IO) if (name is 'IO')
      models.push(fs) if (name is 'fs')
      models.push(clicolor) if (name is 'clicolor')
    models


module.exports = WoQu