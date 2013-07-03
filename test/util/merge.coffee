{expect} = require 'chai'

merge = require '../../src/util/merge'

describe 'merge', ->

  it "should return unmodified base object when second object is undefined", ->
    a =
      foo: 5
      bar: 6
    expect(merge a).to.equal a

  it "should return unmodified base object when second object is empty", ->
    a =
      foo: 5
      bar: 6
    expect(merge a, {}).to.equal a

  it "should deeply merge objects", ->
    a =
      foo:
        x: 78
        y: 60
    b =
      foo:
        x: 89
    ab = merge a, b
    expect(ab.foo.x).to.equal b.foo.x
    expect(ab.foo.y).to.equal a.foo.y

  it "should treat arrays as non-object properties", ->
    a =
      bar: [1, 2]
    b =
      bar: [1, 2, 3]
    ab = merge a, b
    expect(ab.bar).to.equal b.bar
