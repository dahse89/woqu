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

  error: (msg) ->
    @println(msg)
    process.exit()

  getString: (data) ->
    if(typeof data is 'object')
      return JSON.stringify(data,null,4)
    data

  ###*
  * print string in shell
  *###
  print: (str) ->
    @term_ui.out @getString str

  ###*
  * print string in shell with newline
  *###
  println: (str) ->
    @print(@getString(str)+"\n")

  ###*
  * this provides an read line input for the shell
  ###
  readLine: (question,cb) ->
    self = @
    @rl.question question, (answer) ->
      cb(answer,self)
      self.rl.close()

  __date: (date, format = 'DD.MM.YYYY HH:mm:ss') ->
     @moment(date).calendar()


  gotLoggedWork: (work) ->


  ###*
   * convert an instance of task class to string
   * @return string
  ###
  printTask: (task,cb) ->

    create_date_label = @__date(task.createdAt)
    task_lable = @clc.white('Task: #')
    [_$,$_] = [@clc.red('['),@clc.red(']')]
    id = @clc.blue(task.id)
    done_at_label = if task.done_at then "#{_$}done#{$_}: " + @__date(task.done_at) else ' '
    workLog = ''
    task.getLoggedWorks().then (work) =>
      workLog += "   #{@__date(w.createdAt)}: #{w.text}\n" for w in work
      console.log """
              #{task_lable}#{id} added: #{create_date_label}
              #{task.description}
              #{_$}postponed#{$_}: #{task.postponed}
              #{done_at_label}
              #{workLog}
            """
      cb()


module.exports = IO