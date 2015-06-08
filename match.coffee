any = (s, i, l) -> i >= 0 and i + l <= s.length

range = (r, c) -> r[0] <= c <= r[1]

# avoids subbing out of haystack (potentially LARGE)
raw = (s, i, needle) ->
	return false for c, x in needle when c isnt s[i + x]
	return true

set = (set, c) -> c in set

module.exports = { any, range, raw, set }

return unless require.main is module

{ strictEqual } = require 'assert'

strictEqual any('cat',  0,  3), true,  'any()'
strictEqual any('cat', -1,  3), false, 'any()'
strictEqual any('cat', -1,  0), false, 'any()'

strictEqual range('az', 'a'), true,  'range()'
strictEqual range('09', 'a'), false, 'range()'

strictEqual raw('catdog', 3, 'dog'), true,  'raw()'
strictEqual raw('catxxx', 3, 'dog'), false, 'raw()'

strictEqual set('abc', 'a'), true,  'set()'
strictEqual set('abc', '1'), false, 'set()'
