WoQu = do ->
  # privates
  Db = require('./Db.js')
  db   = null
  fs   = require 'fs'
  clicolor = require 'cli-color'
  _IO = require './IO.js'
  IO = null
  CmdsFactory = require './CmdsFactory.js'

  args = null
  devMode = true

  #public
  ###*
  * start woqu app and handle args
  ###
  run: (_devMode) ->
    db = new Db(WoQu)
    IO = new _IO(WoQu)
    #db.init () -> WoQu.ready _devMode
    WoQu.ready _devMode

  ready: (_devMode) ->
    devMode = _devMode
    args = WoQu.getArgs()
    @factory(args[0],args.slice(1)).init()


  factory: (name, args)->
    CmdsFactory.setMaster(WoQu)
    CmdsFactory.get(name,args)

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
  * get LoggedWord class
  * @return LoggedWord
  ###
  getLoggedWord: -> LoggedWord

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