class IO

  constructor: (@master) ->
    @readline = require 'readline'
    @term_ui = require './term-ui/TermUI.js'
    @rl = @readline.createInterface
      input: process.stdin,
      output: process.stdout

  printTaskOrmModel: (model) ->
    Task = @master.getTask()
    task = new Task(model)
    @println(task.toString())

  ###*
  * print string in shell
  *###
  print: (str) ->
    @term_ui.out str

  ###*
  * print string in shell with newline
  *###
  println: (str) ->
    @term_ui.out "#{str}\n"

  ###*
  * this provides an read line input for the shell
  ###
  readLine: (question,cb) ->
    self = @
    @rl.question question, (answer) ->
      cb(answer,self)
      self.rl.close()

module.exports = IO