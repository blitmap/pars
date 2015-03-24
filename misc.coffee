Array::first      ?= -> @[0]
Array::last_index ?= -> @length - 1
Array::last       ?= -> @[@last_index()]

Array::equal ?= (o, deep = true) ->
	return true  if o is @
	return false unless o instanceof Array
	return false unless @length is o.length
	return false for v, i in @ when not (v instanceof Array and deep and v.equal(o[i], deep) or v is o[i])
	return true

Array::strict_equal ?= (o) -> @equal o, false

id   = -> ++id.x
id.x = -1

return unless require.main is module

{strictEqual} = require 'assert'

x = [ 'a', 'b', 'c' ]

strictEqual x.first(),      x[0],            'Array::first()'
strictEqual x.last_index(), x.length - 1,    'Array::last_index()'
strictEqual x.last(),       x[x.length - 1], 'Array::last()'

strictEqual ['a']       .equal(['a']),            true,  'Array::equal()'
strictEqual ['a']       .equal(['b']),            false, 'Array::equal()'
strictEqual ['a', []]   .equal(['a', []]),        true,  'Array::equal()'
strictEqual ['a', []]   .equal(['a', []], false), false, 'Array::equal()'
strictEqual ['a', ['b']].equal(['a', ['b']]),     true,  'Array::equal()'

strictEqual [{}].strict_equal([{}]), false, 'Array::strict_equal()'

strictEqual id(), 0, 'id()'
strictEqual id(), 1, 'id()'
