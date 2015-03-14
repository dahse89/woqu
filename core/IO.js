// Generated by CoffeeScript 1.9.1
(function() {
  var IO;

  IO = (function() {
    function IO(master) {
      this.master = master;
      this.readline = require('readline');
      this.term_ui = require('./term-ui/TermUI.js');
      this.moment = require('moment');
      this.clc = require('cli-color');
      this.rl = this.readline.createInterface({
        input: process.stdin,
        output: process.stdout
      });
    }

    IO.prototype.printTaskOrmModel = function(model) {
      var Task, task;
      Task = this.master.getTask();
      task = new Task(model);
      return this.println(task.toString());
    };

    IO.prototype.error = function(msg) {
      return this.println(msg);
    };


    /**
    * print string in shell
    *
     */

    IO.prototype.print = function(str) {
      return this.term_ui.out(str);
    };


    /**
    * print string in shell with newline
    *
     */

    IO.prototype.println = function(str) {
      return this.term_ui.out(str + "\n");
    };


    /**
    * this provides an read line input for the shell
     */

    IO.prototype.readLine = function(question, cb) {
      var self;
      self = this;
      return this.rl.question(question, function(answer) {
        cb(answer, self);
        return self.rl.close();
      });
    };

    IO.prototype.__date = function(date, format) {
      if (format == null) {
        format = 'DD.MM.YYYY HH:mm:ss';
      }
      return this.moment(date).format(format);
    };


    /**
     * convert an instance of task class to string
     * @return string
     */

    IO.prototype.printTask = function(task) {
      var $_, _$, createAtDate, create_date_label, description, done_at, done_at_label, id, idVal, postponed, ref, task_lable;
      createAtDate = task.getDataValue("createdAt");
      create_date_label = this.__date(createAtDate);
      task_lable = this.clc.white('Task: #');
      ref = [this.clc.red('['), this.clc.red(']')], _$ = ref[0], $_ = ref[1];
      idVal = task.getDataValue("id");
      id = this.clc.blue(idVal);
      done_at = task.getDataValue("done_at");
      done_at_label = done_at ? (_$ + "done" + $_ + ": ") + this.__date(done_at) : ' ';
      description = task.getDataValue("description");
      postponed = task.getDataValue("postponed");
      return this.println("" + task_lable + id + " From: " + create_date_label + "\n" + description + "\n" + _$ + "postponed" + $_ + ": " + postponed + "\n" + done_at_label);
    };

    return IO;

  })();

  module.exports = IO;

}).call(this);
