module.exports = class CmdsFactory
  @subCommandsDir = './cmds/'
  @coreDir = './core/cmds/'
  @fs = require 'fs'
  @instances = {}
  @master = null

  @setMaster: (@master) ->

  @get: (name, args = []) ->
    name = @toCoreModelName(name)

    if @instances[name]
      return @instances[name]
    else
      model = @getModel(name)
      new model(@master, args)

  @getCoreDir: -> @coreDir

  ###*
  * ensure that sub comment is in model name format
  * (first char uppercase )
  ###
  @toCoreModelName: (str) ->
    str += ''
    f = str.charAt(0).toUpperCase()
    f + str.substr(1).toLowerCase()

  ###*
  * get sub model
  * @return subModel_ref
  ###
  @getModel: (model) ->

    path = CmdsFactory.coreDir + model + '.js'
    requirePath = CmdsFactory.subCommandsDir + model
    if CmdsFactory.fs.existsSync(path)
      require(requirePath)
    else
      console.log "invalid command: #{model}"
      process.exit()