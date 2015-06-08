Array::equal ?= (o, deep = true) ->
	return true  if o is @
	return false unless o instanceof Array
	return false unless @length is o.length
	return false for v, i in @ when not (v instanceof Array and deep and v.equal(o[i], deep) or v is o[i])
	return true

Array::strict_equal ?= (o) -> @equal o, false

Array::clone ?= -> @slice()

# inherited by Array *and* String
Object::first      ?= -> @[0]
Object::last       ?= -> @[@last_index()]
Object::last_index ?= -> @length - 1

Number::bit ?= (i, b) ->
	n = @valueOf()
	return n ^ (-b ^ n) & (1 << i) if b?
	return !!(n >> i & 1)

id   = -> ++id.x
id.x = -1

module.exports = { id }

return unless require.main is module

{ strictEqual } = require 'assert'

strictEqual ['a']       .equal('cat'),            false, 'Array::equal()'
strictEqual ['a']       .equal(['a']),            true,  'Array::equal()'
strictEqual ['a']       .equal(['b']),            false, 'Array::equal()'
strictEqual ['a', []]   .equal(['a', []]),        true,  'Array::equal()'
strictEqual ['a', []]   .equal(['a', []], false), false, 'Array::equal()'
strictEqual ['a', ['b']].equal(['a', ['b']]),     true,  'Array::equal()'

strictEqual [{}].strict_equal([{}]), false, 'Array::strict_equal()'

x = [ 'a', 'b', 'c' ]
y = x.clone()

strictEqual y isnt x and y.equal(x), true, 'Array::clone()'

strictEqual x.first(),      x[0],            'Object::first()'
strictEqual x.last_index(), x.length - 1,    'Object::last_index()'
strictEqual x.last(),       x[x.length - 1], 'Object::last()'

strictEqual 'cat'.first(),      'c', 'Object::first()'
strictEqual 'cat'.last_index(), 2,   'Object::last_index()'
strictEqual 'cat'.last(),       't', 'Object::last()'

strictEqual (2).bit(1), true, 'Number::bit()'
strictEqual (4).bit(2), true, 'Number::bit()'
strictEqual (8).bit(3), true, 'Number::bit()'

strictEqual (2).bit(1, false), 0, 'Number::bit()'
strictEqual (0).bit(1, true ), 2, 'Number::bit()'

strictEqual id(), 0, 'id()'
strictEqual id(), 1, 'id()'
