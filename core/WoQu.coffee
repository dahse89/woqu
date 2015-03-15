module.exports = class WoQu

  constructor: (@devMode) ->
    CmdsFactory = require('./CmdsFactory.js')
    @args = process.argv.slice(2)
    @coreModels =
      fs: require 'fs'
      cliColor: require 'cli-color'
      db: null
      IO: null
      config: null

      cmdsFactory: CmdsFactory.setMaster(@)

  woqu: (name, args)->
    @factory('cmdsFactory').get(name,args)

  factory: (names...) ->
    models = []
    if names.length > 0
      for k,v of names
        path = v.split '/'
        if path.length > 1
          switch path[0]
            when 'model' then models.push(@factory('db').getModel(path[1]))
            when 'cmd' then models.push(@woqu(path[1],path.slice(2)))
            when 'config' then models.push(@factory('config').get(path[1]))
        else
          models.push(@coreModels[path[0]])

    if models.length is 1
      return models[0]

    return models

  run: ->
    Db = require('./Db');
    IO = require('./IO');
    @coreModels.config = require 'config'
    @coreModels.db = new Db(@)
    @coreModels.IO = new IO(@)
    @ready()

  ready: () ->
    @woqu(@args[0],@args.slice(1)).init()



