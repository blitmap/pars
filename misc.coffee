Array::equal ?= (o, deep = true) ->
	return true  if o is @
	return false unless o instanceof Array
	return false unless @length is o.length
	return false for v, i in @ when not (v instanceof Array and deep and v.equal(o[i], deep) or v is o[i])
	return true

Array::strict_equal ?= (o) -> @equal o, false

Function::property ?= (prop, desc) -> Object.defineProperty @::, prop, desc

# inherited by Array *and* String
Object::first      ?= -> @[0]
Object::last       ?= -> @[@last_index()]
Object::last_index ?= -> @length - 1

Object::values ?= (o) -> (v for own _, v of o)

Number::bit ?= (i, b) ->
	n = @valueOf()
	return n ^ (-b ^ n) & (1 << i) if b?
	return !!(n >> i & 1)

id   = -> ++id.x
id.x = -1

module.exports = { id }

return unless require.main is module

{ ok, strictEqual } = require 'assert'

bad = ->
	arguments[0] = not arguments[0]
	ok arguments...

bad ['a']       .equal 'cat'
ok  ['a']       .equal ['a']
bad ['a']       .equal ['b']
ok  ['a', []]   .equal ['a', []]
bad ['a', []]   .equal ['a', []], false
ok  ['a', ['b']].equal ['a', ['b']]

bad [{}].strict_equal [{}]

class Whatever
	@property 'cat',
		get: -> 'dog'

strictEqual (new Whatever).cat, 'dog'

x = [ 'a', 'b', 'c' ]

strictEqual x.first(),      x[0]
strictEqual x.last_index(), x.length - 1
strictEqual x.last(),       x[x.length - 1]

strictEqual Object.values({ a: 'cat', b: 'dog', c: 'rat', d: 'horse' })[2], 'rat'

strictEqual 'cat'.first(),      'c'
strictEqual 'cat'.last_index(), 2
strictEqual 'cat'.last(),       't'

ok (2).bit 1
ok (4).bit 2
ok (8).bit 3

strictEqual (2).bit(1, false), 0
strictEqual (0).bit(1, true ), 2

strictEqual id(), 0
strictEqual id(), 1
strictEqual id(), 2
