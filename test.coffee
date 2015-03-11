###
  { id: null,
  description: null,
  created_at: null,
  postponed: null,
  done_at: null }

###
Sequelize = require('sequelize')
sequelize = new Sequelize 'Test', '', '',
  host: 'localhost',
  dialect: 'sqlite',
  storage: './test.db'


User = sequelize.define 'user'
  first_name: type: Sequelize.STRING
  last_name: type: Sequelize.STRING


User.sync(fore: true).then () ->
  User.create
    first_name: 'Philipp2',
    last_name: 'Dahse2',
    moreStuff: "we",
    someWeDoNotNeed: 12
