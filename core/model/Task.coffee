moment = require('moment')

class Task
  constructor: ->
    @id = null
    @description = null
    @created_at = null
    @postponed = null
    @done_at = null

  getId: -> @id
  setId: (id) ->
    @id = id
    @
  getDescription: -> @description
  setDescription: (desc) ->
    @description = desc
    @
  getCreatedAt: -> @created_at
  setCreatedAt: (date) ->
    @created_at = date
    @
  getPostponed: -> @postponed
  increasePostponed: -> @postponed++
  setPostponed: (number) ->
    @postponed = number
    @
  getDoneAt: -> @done_at
  setDoneAt: (date) ->
    @done_at = date
    @
  init: (obj) ->
    for key,val of obj
      @[key] = val
    @
  to$Obj: ->
    arr = {}
    for key,val of @
      if typeof val isnt 'function'
        arr['$'+key] = if val instanceof Date then val.getTime() else val
    arr
  toString: ->
    """
      Task ##{@id} From: #{moment(@created_at).format('DD.MM.YYYY HH:mm:ss')}
      #{@description}
      [postponed]: #{@postponed}
      #{if @done_at then '[done]: ' + moment(@done_at).format('DD.MM.YYYY HH:mm:ss') else ' '}
    """

module.exports = Task



