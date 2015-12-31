C = {}

###

Types:
	- ANY: match a length of any characters
	- COMPOUND: matches several rules at the same position
	- CHOICE: ordered choice / alternation
	- MINMAX: match something [min, max] times
	- RANGE: a character range
	- RAW: match a string
	- SET: a set of characters
	- SEQUENCE: logical-and, sequential matching

Modifiers:
	- BACK: match behind the current position
	- NOCASE: no case sensitivity
	- NOT: logically invert the match

###

TYPES     = 'ANY COMPOUND CHOICE MINMAX RANGE RAW REFERENCE SET SEQUENCE'.split ' '
MODIFIERS = 'BACK NOCASE NOCONSUME NOT'.split ' '

C[c] = 1 << i for c, i in TYPES.concat MODIFIERS

C.TYPE_MASK = C[MODIFIERS[0]] - 1
C.MOD_MASK  = ~C.TYPE_MASK

module.exports = C

return unless require.main is module

{ strictEqual } = require 'assert'

ks = Object.keys   C
vs = Object.values C

strictEqual ks.length,       (new Set ks).size, 'constants must have unique identifiers'
strictEqual vs.length,       (new Set vs).size, 'constants must have unique values'
strictEqual ks.length <= 32, true,              'too many constants'
