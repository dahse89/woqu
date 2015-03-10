Db = do ->
  #privates
  sqlite3 = require('sqlite3').verbose();
  Task = require './model/Task.js'
  name = "woqu.db"
  conn = null
  ready = null

  ###*
  * create connection and init db class
  * @param cb function
  ###
  init: (cb)->
    ready = cb;
    conn = new sqlite3.Database(name,Db.createTables)

  ###*
  * create needed tables
  * @param err sqlite_error
  ###
  createTables: (err)->
    console.error(err) if err
    Db.createTaskTable()

  ###*
  * create Task table
  ###
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


  ###*
  * get a single Task by id
  * @param id string
  * @paran cb function
  ###
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

  ###*
  * get current Task that people have do
  * @param cb function
  ###
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

  ###*
  * update a Task in sqlite db
  * @param task Task
  * @param cb function
  ###
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

  ###*
  * insert a new task to sqlite db
  * @param task Task
  ###
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

module.exports = Db