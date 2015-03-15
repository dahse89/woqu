// Generated by CoffeeScript 1.9.1
(function() {
  var Add;

  module.exports = Add = (function() {
    function Add(master, args) {
      this.master = master;
      this.args = args;
    }

    Add.prototype.init = function() {
      var IO;
      IO = this.master.factory('IO');
      if (this.args.length === 0) {
        IO.readLine("Description: ", function(answer, IO) {
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
      var IO, Task, ref, task;
      ref = this.master.factory('IO', 'model/Task'), IO = ref[0], Task = ref[1];
      task = Task.build({
        description: description,
        poststponed: 0
      });
      return task.save()["catch"](IO.error).then(function(task) {
        IO.println("Add Task: #" + task.id);
        return process.exit();
      });
    };

    return Add;

  })();

  module.exports = Add;

}).call(this);
