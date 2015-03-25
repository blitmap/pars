# avoids subbing out of haystack (potentially LARGE)
raw = (s, i, needle) ->
	return false for c, x in needle when c isnt s[i + x]
	return true

range = (s, i, lowhigh) -> !!s[i] and lowhigh[0] <= s[i] <= lowhigh[1]

set = (s, i, set) -> s[i] in set

any = (s, i, l) -> i >= 0 and (l is 0 or !!s[i + l - 1])

return unless require.main is module

{strictEqual} = require 'assert'

strictEqual raw('catdog', 3, 'dog'), true,  'raw()'
strictEqual raw('catxxx', 3, 'dog'), false, 'raw()'

strictEqual range('abc', 1, 'az'), true,  'range()'
strictEqual range('abc', 1, '09'), false, 'range()'

strictEqual set('xxa', 2, 'abc'), true,  'set()'
strictEqual set('xx1', 2, 'abc'), false, 'set()'

strictEqual any('cat',  0,  3), true,  'any()'
strictEqual any('cat', -1,  3), false, 'any()'
strictEqual any('cat', -1,  0), false, 'any()'
