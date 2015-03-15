// Generated by CoffeeScript 1.9.1
(function() {
  var Db;

  module.exports = Db = (function() {
    function Db(master) {
      this.master = master;
      this.debugOutput = true;
      this.update = true;
      this.modelsDir = __dirname + '/model/sequelizeModels/';
      this.Sequelize = require('sequelize');
      this.instances = {};
      this.connect();
    }

    Db.prototype.connect = function() {
      var dbConfig;
      dbConfig = this.master.factory('config/database');
      this.sequelize = new this.Sequelize('', '', '', {
        host: dbConfig.host,
        dialect: dbConfig.dialect,
        storage: dbConfig.storage,
        logging: dbConfig.debug_output ? console.log : false
      });
      return this.loadModels();
    };

    Db.prototype.loadModels = function() {
      var file, files, fs, i, model;
      fs = this.master.factory('fs');
      files = fs.readdirSync(__dirname + '/model/sequelizeModels');
      for (i in files) {
        file = files[i];
        if (/\.js$/.test(file)) {
          model = file.replace(/\.js$/, '');
          this.instances[model] = this.sequelize["import"](this.modelsDir + model);
        }
      }
      return this.initRelationships();
    };

    Db.prototype.initRelationships = function() {
      this.instances.Task.hasMany(this.instances.LoggedWork);
      return this.instances.Task.hasMany(this.instances.Info);
    };

    Db.prototype.updateDbSchema = function(mode) {
      this.update = mode;
      return this.sync();
    };

    Db.prototype.sync = function() {
      var mode;
      mode = this.update;
      return this.sequelize.sync({
        force: mode
      })["catch"](function(error) {
        return console.log(error);
      }).then(function() {
        console.log((mode ? 'hard' : 'soft') + " update done");
        return process.exit();
      });
    };

    Db.prototype.getModels = function() {
      return this.instances;
    };

    Db.prototype.getModel = function(name) {
      return this.instances[name];
    };

    Db.prototype.getChainer = function() {
      return new this.Sequelize.Utils.QueryChainer();
    };

    return Db;

  })();

}).call(this);
