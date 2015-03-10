# usings
moment  = require 'moment'
clc = require 'cli-color'
###*
* Task
* data model representing a task that have to be done
###
class Task
  ###*
  * class constructor
  * initialize private properies
  ###
  constructor: ->
    @id = null
    @description = null
    @created_at = null
    @postponed = null
    @done_at = null

  ###*
  * id getter
  * @return int
  ###
  getId: -> @id

  ###*
  * id setter
  * @param id int
  ###
  setId: (id) ->
    @id = id
    @

  ###*
  * description getter
  * @return string
  ###
  getDescription: -> @description

  ###*
  * id setter
  * @param id int
  ###
  setDescription: (desc) ->
    @description = desc
    @

  ###*
  * reated_at getter
  * @return Date
  ###
  getCreatedAt: -> @created_at

  ###*
  * id setter
  * @param date Date
  ###
  setCreatedAt: (date) ->
    @created_at = date
    @

  ###*
  * postponed getter
  * @return int
  ###
  getPostponed: -> @postponed

  ###*
  * increase postponed property
  ###
  increasePostponed: -> @postponed++

  ###*
  * postponed setter
  * @param postponed int
  ###
  setPostponed: (number) ->
    @postponed = number
    @

  ###*
  * done_at getter
  * @return Date
  ###
  getDoneAt: -> @done_at

  ###*
  * done_at setter
  * @param done_at Date
  ###
  setDoneAt: (date) ->
    @done_at = date
    @

  ###*
  * initialize an instance of this class by an object
  * @param obj Object
  ###
  init: (obj) ->
    for key,val of obj
      @[key] = val
    @

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

module.exports = Task



