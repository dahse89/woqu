class IO

  constructor: (@master) ->
    @readline = require 'readline'
    @term_ui = require './term-ui/TermUI.js'
    @moment  = require 'moment'
    @clc = require 'cli-color'

    @rl = @readline.createInterface
      input: process.stdin,
      output: process.stdout

  printTaskOrmModel: (model) ->
    Task = @master.getTask()
    task = new Task(model)
    @println(task.toString())

  error: (msg) -> @println(msg)

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

  __date: (date, format = 'DD.MM.YYYY HH:mm:ss') ->
     @moment(date).format format



  ###*
   * convert an instance of task class to string
   * @return string
  ###
  printTask: (task) ->
    createAtDate = task.getDataValue("createdAt")
    create_date_label = @__date(createAtDate)
    task_lable = @clc.white('Task: #')
    [_$,$_] = [@clc.red('['),@clc.red(']')]
    idVal = task.getDataValue("id")
    id = @clc.blue(idVal)
    done_at = task.getDataValue("done_at")
    done_at_label = if done_at then "#{_$}done#{$_}: " + @__date(done_at) else ' '
    description = task.getDataValue("description")
    postponed = task.getDataValue("postponed")
    @println(
      """
        #{task_lable}#{id} From: #{create_date_label}
        #{description}
        #{_$}postponed#{$_}: #{postponed}
        #{done_at_label}
      """
    )

module.exports = IO