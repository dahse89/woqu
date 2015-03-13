Sqlz = require('sequelize')

class Db
  constructor: (@master) ->
    @update = true
    @debugOutput = false
    @models = {}
    @orm = new Sqlz 'Test', '', '',
      host: 'localhost',
      dialect: 'sqlite',
      storage: './tasks.db',
      logging: @debugOutput


  getModels: -> @models
  getOrm: -> @orm

  init: (ready) ->
    # schemas
    taskSchema =
      id: type: Sqlz.INTEGER, autoIncrement: true, primaryKey: true
      description: type: Sqlz.TEXT
      postponed: type: Sqlz.INTEGER
      done_at: type: Sqlz.DATE

    loggedWorkSchema =
      id: type: Sqlz.INTEGER, autoIncrement: true, primaryKey: true
      text: type: Sqlz.TEXT


    # models
    @models.Task = @orm.define 'task', taskSchema
    @models.LoggedWork = @orm.define 'logged_work', loggedWorkSchema

    # relations
    @models.Task.hasMany(@models.LoggedWork)


    [models,orm] = [@models,@orm]
    # todo Check why LoggedWord can not be synced
    @models.LoggedWork.sync(force: @update).then () ->
      @models.Task.sync(force: @update).then () ->
        ready(orm,models)

module.exports = Db

