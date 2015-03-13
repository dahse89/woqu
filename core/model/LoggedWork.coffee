module.exports = class LoggedWork extends require './SuperModel'
  constructor: (ormDataModel = null)->
    @text = null

  fromOrm: (ormModel) ->
    dataValues = ormModel.dataValues
    @seText(dataValues.text)

  getText: -> @text
  setText: (@text) -> @

