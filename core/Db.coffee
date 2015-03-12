Sqlz = require('sequelize')

class Db
  constructor: (@master) ->
    @update = false
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
    taskSchema =
      id: type: Sqlz.INTEGER, autoIncrement: true, primaryKey: true
      description: type: Sqlz.TEXT
      postponed: type: Sqlz.INTEGER
      done_at: type: Sqlz.DATE

    @models.Task = @orm.define 'task', taskSchema

    [models,orm] = [@models,@orm]
    # todo sync chain for all models
    @models.Task.sync(force: @update).then () ->
      ready(orm,models)

module.exports = Db

###*
Db = do ->
#privates
sqlite3 = require('sqlite3').verbose();
Task = require './model/Task.js'
name = "woqu.db"
conn = null
ready = null


init: (cb)->
  ready = cb;
  conn = new sqlite3.Database(name,Db.createTables)


createTables: (err)->
  console.error(err) if err
  Db.createTaskTable()

createTaskTable: ->
  conn.run "
    CREATE TABLE IF NOT EXISTS tasks(
      id INTEGER PRIMARY KEY,
      description TEXT,
      created_at INTEGER,
      postponed INTEGER,
      done_at NUMBER
    )
  ", (err)->
    console.error(err) if err
    ready(Db)



getTaskById: (id,cb)->
  conn.each "
    SELECT
      id,
      description,
      created_at,
      postponed,
      done_at
    FROM tasks
    WHERE id = '#{id}'
    LIMIT 1", (err, row) ->
    console.error(err) if err
    task = new Task();
    task.init(row)
    cb(task)


getCurrentTask: (cb) ->
  conn.each "
    SELECT
      id,
      description,
      created_at,
      postponed,
      done_at
    FROM tasks
    WHERE done_at IS NULL
    ORDER by (id+postponed),postponed,id ASC
    LIMIT 1", (err, row) ->
    console.error(err) if err
    task = new Task();
    task.init(row)
    cb(task)


updateTask: (task, cb) ->
  stmt = conn.prepare "
    UPDATE tasks SET
      description = $description,
      created_at = $created_at,
      postponed = $postponed,
      done_at  = $done_at
    WHERE id = $id
  "
  stmt.run(task.to$Obj(),cb)

insertTask: (task,cb) ->
  stmt = conn.prepare "
    INSERT INTO tasks (
      id,
      description,
      created_at,
      postponed,
      done_at
    ) VALUES (
      $id,
      $description,
      $created_at,
      $postponed,
      $done_at
    )
  "
  stmt.run(task.to$Obj(),cb)
###
