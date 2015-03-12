###*
  * This is the data model for a task
  * The object looks a litte bit differnt in the db
  * Only the values defines in task schema are stored (core/Db)
  * The model in initialized from orm object using fromOrm() method
###

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
  constructor: (ormDataModel = null)->
    @id = null
    @description = null
    @created_at = null
    @postponed = null
    @done_at = null
    @created_at = null
    @updated_at = null

    @fromOrm(ormDataModel) if(ormDataModel isnt null)


  fromOrm: (ormModel) ->
    dataValues = ormModel.dataValues
    @setId(dataValues.id)
    @setDescription(dataValues.description)
    @setPostponed(dataValues.postponed)
    @setDoneAt(dataValues.done_at)
    @setCreateAt(dataValues.createdAt)
    @setUpdateAt(dataValues.updatedAt)


  setCreateAt: (created_at) ->
    @created_at = created_at
    @
  getCreateAt: -> @created_at

  setUpdateAt: (updated_at) ->
    @updated_at = updated_at
    @
  getUpdateAt: -> @updated_at


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



