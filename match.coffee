any = (s, i, l) -> i >= 0 and i + l <= s.length

range = (r, c, nocase) ->
	return true if r[0] <= c <= r[1]
	return true if nocase and r[0] <= c.toLowerCase() <= r[1]
	return false

# avoids subbing out of haystack (potentially LARGE)
raw = (s, i, needle, nocase) ->
	if nocase
		return false for c, x in needle when c.toLowerCase() isnt s[i + x].toLowerCase()
	else
		return false for c, x in needle when c isnt s[i + x]

	return true

set = (set, c, nocase) ->
	return true if c in set
	return true if nocase and c.toLowerCase() in set
	return false

module.exports = { any, range, raw, set }

return unless require.main is module

{ strictEqual } = require 'assert'

strictEqual any('cat',  0,  3), true,  'any()'
strictEqual any('cat', -1,  3), false, 'any()'
strictEqual any('cat', -1,  0), false, 'any()'

strictEqual range('az', 'a'),       true,  'range()'
strictEqual range('09', 'a'),       false, 'range()'
strictEqual range('az', 'A', true), true,  'range()'

strictEqual raw('catdog', 3, 'dog'),       true,  'raw()'
strictEqual raw('catxxx', 3, 'dog'),       false, 'raw()'
strictEqual raw('catdog', 3, 'DoG', true), true,  'raw()'

strictEqual set('abc', 'a'),       true,  'set()'
strictEqual set('abc', '1'),       false, 'set()'
strictEqual set('abc', 'B', true), true,  'set()'
