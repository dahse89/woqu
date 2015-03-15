// Generated by CoffeeScript 1.9.1
(function() {
  var Done;

  module.exports = Done = (function() {
    function Done(master, args) {
      this.master = master;
      this.args = args;
    }

    Done.prototype.init = function() {
      return this.setDone();
    };


    /**
    * set current Task to done and print it
     */

    Done.prototype.setDone = function() {
      var IO, todo;
      IO = this.master.factory("IO");
      todo = this.master.woqu('todo');
      return todo.getCurrentTask(function(task) {
        var attr, where;
        attr = {
          done_at: new Date()
        };
        where = {
          where: {
            id: task.id
          }
        };
        return task.update(attr, where).then(function() {
          IO.printTask(task);
          return todo.init();
        })["catch"](function(err) {
          return console.log(err);
        });
      });
    };

    return Done;

  })();

  module.exports = Done;

}).call(this);
