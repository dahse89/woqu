module.exports = class Db
  constructor: (@master) ->
    @debugOutput = true;
    @update = true;
    @modelsDir = __dirname + '/model/sequelizeModels/'
    @Sequelize = require('sequelize')
    @instances = {}
    @connect()
  connect: ->
    dbConfig = @master.factory('config/database')
    @sequelize = new @Sequelize '', '', '',
        host: dbConfig.host,
        dialect: dbConfig.dialect,
        storage: dbConfig.storage,
        logging: if dbConfig.debug_output then console.log else no
    @loadModels()
  loadModels: ->
    fs = @master.factory('fs')
    files = fs.readdirSync(__dirname + '/model/sequelizeModels')
    for i,file of files
      if /\.js$/.test(file)
        model = file.replace(/\.js$/,'')
        @instances[model] = @sequelize.import @modelsDir + model
    @initRelationships()

  initRelationships: ->
    @instances.Task.hasMany(@instances.LoggedWork)
    @instances.Task.hasMany(@instances.Info)

  updateDbSchema: (mode) ->
    @update = mode
    @sync()

  sync: ->
    mode = @update
    @sequelize.sync force: mode
      .catch (error) -> console.log error
      .then ->
          console.log "#{if mode then 'hard' else 'soft'} update done"
          process.exit()


  getModels: -> @instances
  getModel: (name) -> @instances[name]
  getChainer: -> new @Sequelize.Utils.QueryChainer()



