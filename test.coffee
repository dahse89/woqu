class CmdInterface
  init: -> console.log("super")

class Test extends CmdInterface
  constructor: ->
    @val = null

  init: ->
    super
    console.log("bla")
  test: (v) ->
    super
    @val = v

  getVal: -> @val

class Multiton
  @singletions =
    Test: Test
  @instances = {}
  @get: (name, args...) -> @instances[name] ||= new @singletions[name] args...

  @x: (args...) -> x[y] ||= y args...





t = Multiton.get('Test')
t.init();
t.test("lol")
console.log(t.getVal())

x = Multiton.get('Test')
console.log(x.getVal())

console.log(t is x)
