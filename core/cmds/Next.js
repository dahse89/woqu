// Generated by CoffeeScript 1.9.1
(function() {
  var Next;

  module.exports = Next = (function() {
    function Next(master, args) {
      this.master = master;
      this.args = args;
    }

    Next.prototype.init = function() {
      return this.moveCurTaskBackwards();
    };


    /**
    * update Task to increase postponed
     */

    Next.prototype.moveCurTaskBackwards = function() {
      var IO, msg, ref, todo;
      ref = this.master.factory('cmd/todo', 'IO', 'config/messages.noTaskOpen'), todo = ref[0], IO = ref[1], msg = ref[2];
      return todo.getCurrentTask(function(task) {
        if (task === null) {
          IO.println(msg);
          return process.exit();
        } else {
          return task.increment('postponed').then(function() {
            return todo.init();
          });
        }
      });
    };

    return Next;

  })();

  module.exports = Next;

}).call(this);
