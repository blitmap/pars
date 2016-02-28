Array::equal ?= (o, deep = true) ->
	return true  if o is @
	return false unless o instanceof Array
	return false unless @length is o.length
	return false for v, i in @ when not (v instanceof Array and deep and v.equal(o[i], deep) or v is o[i])
	return true

Array::strict_equal ?= (o) -> @equal o, false

Function::property = (prop, desc) -> Object.defineProperty @::, prop, desc

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

fail = ->
	arguments[0] = not arguments[0]
	ok arguments...

fail ['a']       .equal('cat'),            'Array::equal()'
ok   ['a']       .equal(['a']),            'Array::equal()'
fail ['a']       .equal(['b']),            'Array::equal()'
ok   ['a', []]   .equal(['a', []]),        'Array::equal()'
fail ['a', []]   .equal(['a', []], false), 'Array::equal()'
ok   ['a', ['b']].equal(['a', ['b']]),     'Array::equal()'

fail [{}].strict_equal([{}]), 'Array::strict_equal()'

class Whatever
	@property 'cat',
		get: -> 'dog'

strictEqual (new Whatever).cat, 'dog', 'Function::property()'

x = [ 'a', 'b', 'c' ]

strictEqual x.first(),      x[0],            'Object::first()'
strictEqual x.last_index(), x.length - 1,    'Object::last_index()'
strictEqual x.last(),       x[x.length - 1], 'Object::last()'

strictEqual Object.values({ a: 'cat', b: 'dog', c: 'rat', d: 'horse' })[2], 'rat', 'Object::values()'

strictEqual 'cat'.first(),      'c', 'Object::first()'
strictEqual 'cat'.last_index(), 2,   'Object::last_index()'
strictEqual 'cat'.last(),       't', 'Object::last()'

ok (2).bit(1), 'Number::bit()'
ok (4).bit(2), 'Number::bit()'
ok (8).bit(3), 'Number::bit()'

strictEqual (2).bit(1, false), 0, 'Number::bit()'
strictEqual (0).bit(1, true ), 2, 'Number::bit()'

strictEqual id(), 0, 'id()'
strictEqual id(), 1, 'id()'
strictEqual id(), 2, 'id()'
