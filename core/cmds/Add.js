// Generated by CoffeeScript 1.9.1
(function() {
  var Add;

  module.exports = Add = (function() {
    function Add(master, args) {
      var ref;
      this.master = master;
      this.args = args;
      ref = this.master.coreModels("db", "IO"), this.db = ref[0], this.IO = ref[1];
    }

    Add.prototype.init = function() {
      if (this.args.length === 0) {
        this.IO.readLine("Description: ", function(answer, IO) {
          return IO.println("Thank you for your valuable feedback:" + answer);
        });
        return;
      }
      if (this.args.length === 1) {
        return this.addTask(this.args[0]);
      }
    };


    /**
    * add a Task to database
     */

    Add.prototype.addTask = function(description) {
      var IO, task;
      IO = this.IO;
      task = this.db.getModel('Task').build({
        description: description,
        poststponed: 0
      });
      return task.save()["catch"](IO.error).then(function(task) {
        IO.println("Add Task: #" + (task.getDataValue('id')));
        return process.exit();
      });
    };

    return Add;

  })();

  module.exports = Add;

}).call(this);
