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
      var cfg;
      console.log("do tests here");
      cfg = this.master.factory('config');
      return console.log(cfg.getImpl);
    };

    return Test;

  })();

}).call(this);
