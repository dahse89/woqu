
IO = do ->
  readline = require 'readline'
  rl = readline.createInterface
    input: process.stdin,
    output: process.stdout

  ###*
  * this provides an read line input for the shell
  ###
  ask: (question,cb) ->
    rl.question question, (answer) ->
      cb(answer)
      rl.close()

module.exports = IO