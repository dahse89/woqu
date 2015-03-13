###*
  * This is the data model for a task
  * The object looks a little bit different in the db
  * Only the values defines in task schema are stored (core/Db)
  * The model in initialized from orm object using fromOrm() method
###

# using
moment  = require 'moment'
clc = require 'cli-color'

###*
 * Task
 * data model representing a task that have to be done
###
module.exports = class Task extends require './SuperModel'
  ###*
   * class constructor
   * initialize private properies
  ###
  constructor: (ormDataModel = null)->
    super(ormDataModel)
    @description = null
    @postponed = null
    @done_at = null

    @fromOrm(ormDataModel) if(ormDataModel isnt null)


  fromOrm: (ormModel) ->
    dataValues = ormModel.dataValues
    @_fromOrm(ormModel)
    @setDescription(dataValues.description)
    @setPostponed(dataValues.postponed)
    @setDoneAt(dataValues.done_at)



  ###*
   * Getter/ Setter
  ###
  getDescription: -> @description
  setDescription: (@description) -> @

  getPostponed: -> @postponed
  setPostponed: (@postponed) -> @

  getDoneAt: -> @done_at
  setDoneAt: (@done_at) -> @

  increasePostponed: -> @postponed++

  ###*
   * converts an instance of this class to an object
   * the properties will be the same then in there but
   * they will all start with $ to use them in sqlite binding
  ###
  to$Obj: ->
    arr = {}
    for key,val of @
      if typeof val isnt 'function'
        arr['$'+key] = if val instanceof Date then val.getTime() else val
    arr

  ###*
   * convert an instance of this class to string
   * @return string
  ###
  toString: ->
    create_date_label = moment(@created_at).format('DD.MM.YYYY HH:mm:ss')
    task_lable = clc.white('Task: #')
    hardBopen = clc.red('[')
    hardBclose = clc.red(']')
    id = clc.blue(@id)
    done_at_label = if @done_at then "#{hardBopen}done#{hardBclose}: " + moment(@done_at).format('DD.MM.YYYY HH:mm:ss') else ' '
    """
      #{task_lable}#{id} From: #{create_date_label}
      #{@description}
      #{hardBopen}postponed#{hardBclose}: #{@postponed}
      #{done_at_label}
    """



