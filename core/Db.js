// Generated by CoffeeScript 1.9.1
(function() {
  var Db;

  module.exports = Db = (function() {
    function Db(master) {
      this.master = master;
      this.debugOutput = false;
      this.update = true;
      this.models = ['Task'];
      this.modelsDir = __dirname + '/model/sequelizeModels/';
      this.Sequelize = require('sequelize');
      this.instances = {};
      this.connect();
    }

    Db.prototype.connect = function() {
      this.sequelize = new this.Sequelize('Test', '', '', {
        host: 'localhost',
        dialect: 'sqlite',
        storage: './tasks.db',
        logging: this.debugOutput ? console.log : false
      });
      return this.loadModels();
    };

    Db.prototype.loadModels = function() {
      var k, model, ref;
      ref = this.models;
      for (k in ref) {
        model = ref[k];
        this.instances[model] = this.sequelize["import"](this.modelsDir + model);
      }
      return this.initRelationships();
    };

    Db.prototype.initRelationships = function() {
      return (function(models) {})(this.instances);
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

    return Db;

  })();

}).call(this);
