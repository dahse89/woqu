module.exports = class Admin

  constructor: (@master, @args) ->

  setbyPath: (obj, path, value) ->
    [IO,specMsg] = @master.factory('IO','config/messages.specifyProperty')

    value = false if value is "false"
    value = true if value is "true"

    properties = path.split '.'
    pointer = obj
    for i,prop of properties
      if i < properties.length - 1
        pointer = pointer[prop]
      else
        if typeof pointer[prop] is 'object'
          IO.println(specMsg)
          IO.println(path)
          IO.println pointer[prop]
          process.exit()
        else
          return pointer[prop] = value
    null

  writePrettyJSONFile: (path, obj, cb) ->
    fs = @master.factory('fs')
    fs.writeFile path, JSON.stringify(obj, null, 4), (err) ->
      if(err)
        console.log(err)
      else
        console.log("JSON saved to " + path);
      cb()

  init: () ->
    if @args[0] is 'dbUpdate'
      db = @master.factory('db');
      return db.updateDbSchema(true)

    if @args[0] is 'dbInstall'
      db = @master.factory('db');
      return db.updateDbSchema(false)

    if @args[0] is 'config'
      path = @args[1]
      [IO,config,fs] = @master.factory('IO','config','fs')
      if !config.has(path)
        IO.error config.messages.configNotFround
      else
        if typeof @args[2] is 'undefined'
          IO.error config.messages.missingArgument
        else
          value = @args[2]
          configFilePath = '../../config/default.json'
          configObject = require configFilePath
          @setbyPath(configObject,path,value)
          outPath = fs.realpathSync(__dirname + '/' + configFilePath)
          @writePrettyJSONFile outPath,configObject, ->
            process.exit()