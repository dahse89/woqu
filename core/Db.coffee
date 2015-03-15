module.exports = class Db
  constructor: (@master) ->
    @debugOutput = true;
    @update = true;
    # todo not needed if you would use all files in dir (readdir)
    @models = ['Task','LoggedWork'];
    @modelsDir = __dirname + '/model/sequelizeModels/'
    @Sequelize = require('sequelize')
    @instances = {}
    @connect()
  connect: ->
    @sequelize = new @Sequelize 'Test', '', '',
        host: 'localhost',
        dialect: 'sqlite',
        storage: './tasks.db',
        logging: if @debugOutput then console.log else no
    @loadModels()
  loadModels: ->
    for k,model of @models
      @instances[model] = @sequelize.import @modelsDir + model
    @initRelationships()
  initRelationships: ->
    @instances.Task.hasMany(@instances.LoggedWork)

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



