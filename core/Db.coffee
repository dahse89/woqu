sqlite3 = require('sqlite3').verbose();
Task = require './model/Task.js'

Db =
  name: "woqu.db"
  conn: null
  ready: null
  init: (cb)->
    Db.ready = cb;
    Db.conn = new sqlite3.Database(Db.name,Db.createTables)
  createTables: (err)->
    console.error(err) if err
    Db.conn.run "
      CREATE TABLE IF NOT EXISTS tasks(
        id INTEGER PRIMARY KEY,
        description TEXT,
        created_at INTEGER,
        postponed INTEGER,
        done_at NUMBER
      )
    ", (err)->
      console.error(err) if err
      Db.ready(Db)

  getTaskById: (id,cb)->
    Db.conn.each "
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
    Db.conn.each "
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
    stmt = Db.conn.prepare "
      UPDATE tasks SET
        description = $description,
        created_at = $created_at,
        postponed = $postponed,
        done_at  = $done_at
      WHERE id = $id
    "
    stmt.run(task.to$Obj(),cb)

  insertTask: (task,cb) ->
    stmt = Db.conn.prepare "
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