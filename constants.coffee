C = {}

TYPES     = 'ANY COMPOUND CHOICE MINMAX RANGE RAW REFERENCE SET SEQUENCE'.split ' '
MODIFIERS = 'BACK CAPTURE NOCASE NOCONSUME NOT'.split ' '

C[c] = 1 << i for c, i in TYPES.concat MODIFIERS

C.TYPE_MASK = C[MODIFIERS[0]] - 1

module.exports = C

return unless require.main is module

{ strictEqual } = require 'assert'

ks = Object.keys C
vs = (v for _, v of C)

strictEqual ks.length,       (new Set ks).size, 'constants must have unique identifiers'
strictEqual vs.length,       (new Set vs).size, 'constants must have unique values'
strictEqual ks.length <= 32, true,              'too many constants'
