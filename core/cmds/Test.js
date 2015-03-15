// Generated by CoffeeScript 1.9.1
(function() {
  var Test;

  module.exports = Test = (function() {
    function Test(master, args) {
      this.master = master;
      this.args = args;
    }


    /**
    * test function
     */

    Test.prototype.init = function() {
      var IO, LoggedWork, Task, ref;
      console.log("do tests here");
      ref = this.master.factory('model/Task', 'model/LoggedWork', 'IO'), Task = ref[0], LoggedWork = ref[1], IO = ref[2];

      /*
      Task.find( where: ['id = 1'], limit: 1).then (task) ->
        work = LoggedWork.build text: "njklxnasjknxl asnx "
        work.save().catch(IO.error).then ->
          task.addLoggedWork(work).then -> console.log "done"
       */
      return Task.find({
        where: ['id = 1'],
        limit: 1
      }).then(function(task) {
        console.log(task.id);
        return task.getLoggedWorks().then(function(works) {
          return works.forEach(function(work) {
            return console.log(work.text);
          });
        });
      });
    };

    return Test;

  })();

}).call(this);
