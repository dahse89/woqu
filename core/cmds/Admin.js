// Generated by CoffeeScript 1.9.1
(function() {
  var Admin;

  module.exports = Admin = (function() {
    function Admin(master, args) {
      this.master = master;
      this.args = args;
    }

    Admin.prototype.setbyPath = function(obj, path, value) {
      var IO, i, pointer, prop, properties, ref, specMsg;
      ref = this.master.factory('IO', 'config/messages.specifyProperty'), IO = ref[0], specMsg = ref[1];
      if (value === "false") {
        value = false;
      }
      if (value === "true") {
        value = true;
      }
      properties = path.split('.');
      pointer = obj;
      for (i in properties) {
        prop = properties[i];
        if (i < properties.length - 1) {
          pointer = pointer[prop];
        } else {
          if (typeof pointer[prop] === 'object') {
            IO.println(specMsg);
            IO.println(path);
            IO.println(pointer[prop]);
            process.exit();
          } else {
            return pointer[prop] = value;
          }
        }
      }
      return null;
    };

    Admin.prototype.writePrettyJSONFile = function(path, obj, cb) {
      var fs;
      fs = this.master.factory('fs');
      return fs.writeFile(path, JSON.stringify(obj, null, 4), function(err) {
        if (err) {
          console.log(err);
        } else {
          console.log("JSON saved to " + path);
        }
        return cb();
      });
    };

    Admin.prototype.init = function() {
      var IO, config, configFilePath, configObject, db, fs, outPath, path, ref, value;
      if (this.args[0] === 'dbUpdate') {
        db = this.master.factory('db');
        return db.updateDbSchema(true);
      }
      if (this.args[0] === 'dbInstall') {
        db = this.master.factory('db');
        return db.updateDbSchema(false);
      }
      if (this.args[0] === 'config') {
        path = this.args[1];
        ref = this.master.factory('IO', 'config', 'fs'), IO = ref[0], config = ref[1], fs = ref[2];
        if (!config.has(path)) {
          return IO.error(config.messages.configNotFround);
        } else {
          if (typeof this.args[2] === 'undefined') {
            return IO.error(config.messages.missingArgument);
          } else {
            value = this.args[2];
            configFilePath = '../../config/default.json';
            configObject = require(configFilePath);
            this.setbyPath(configObject, path, value);
            outPath = fs.realpathSync(__dirname + '/' + configFilePath);
            return this.writePrettyJSONFile(outPath, configObject, function() {
              return process.exit();
            });
          }
        }
      }
    };

    return Admin;

  })();

}).call(this);
