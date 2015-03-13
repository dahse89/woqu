// Generated by CoffeeScript 1.9.1
(function() {
  var SuperModel;

  module.exports = SuperModel = (function() {
    function SuperModel(ormDataModel) {
      if (ormDataModel == null) {
        ormDataModel = null;
      }
      this.id = null;
      this.created_at = null;
      this.updated_at = null;
      if (ormDataModel !== null) {
        this._fromOrm(ormDataModel);
      }
    }

    SuperModel.prototype._fromOrm = function(ormDataModel) {
      var dataValues;
      dataValues = ormDataModel.dataValues;
      this.setId(dataValues.id);
      this.setCreateAt(dataValues.createdAt);
      return this.setUpdateAt(dataValues.updatedAt);
    };

    SuperModel.prototype.getId = function() {
      return this.id;
    };

    SuperModel.prototype.setId = function(id) {
      this.id = id;
      return this;
    };

    SuperModel.prototype.getCreateAt = function() {
      return this.created_at;
    };

    SuperModel.prototype.setCreateAt = function(created_at) {
      this.created_at = created_at;
      return this;
    };

    SuperModel.prototype.getUpdateAt = function() {
      return this.updated_at;
    };

    SuperModel.prototype.setUpdateAt = function(updated_at) {
      this.updated_at = updated_at;
      return this;
    };

    return SuperModel;

  })();

}).call(this);