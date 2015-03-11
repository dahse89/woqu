// Generated by CoffeeScript 1.4.0
(function() {
  var Db, Sqlz;

  Sqlz = require('sequelize');

  Db = (function() {

    function Db(master) {
      this.master = master;
      this.update = false;
      this.models = {};
      this.orm = new Sqlz('Test', '', '', {
        host: 'localhost',
        dialect: 'sqlite',
        storage: './tasks.db'
      });
    }

    Db.prototype.init = function(ready) {
      var models, orm, _ref;
      this.models.Task = this.orm.define('task', {
        task_id: {
          type: Sqlz.INTEGER,
          autoIncrement: true,
          primaryKey: true
        },
        description: {
          type: Sqlz.TEXT
        },
        postponed: {
          type: Sqlz.INTEGER
        },
        done_at: {
          type: Sqlz.DATE
        }
      });
      _ref = [this.models, this.orm], models = _ref[0], orm = _ref[1];
      return this.models.Task.sync({
        force: this.update
      }).then(function() {
        return ready(orm, models);
      });
    };

    return Db;

  })();

  /**
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
  */


  module.exports = Db;

}).call(this);
