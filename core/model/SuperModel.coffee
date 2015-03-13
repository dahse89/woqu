module.exports = class SuperModel
  constructor: (ormDataModel = null) ->
    @id = null
    @created_at = null
    @updated_at = null
    @_fromOrm(ormDataModel) if ormDataModel isnt null


  _fromOrm: (ormDataModel) ->
    dataValues = ormDataModel.dataValues
    @setId(dataValues.id)
    @setCreateAt(dataValues.createdAt)
    @setUpdateAt(dataValues.updatedAt)

  getId: -> @id
  setId: (@id) -> @

  getCreateAt: -> @created_at
  setCreateAt: (@created_at) -> @

  getUpdateAt: -> @updated_at
  setUpdateAt: (@updated_at) -> @
