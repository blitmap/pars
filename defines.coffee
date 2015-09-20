C = {}

# types + modifiers (alphabetical, modifiers come 2nd; order is important!)
C[c] = 1 << i for c, i in 'ANY CHOICE MINMAX RANGE RAW REFERENCE SET SEQUENCE BACK CAPTURE NOCASE NOT'.split ' '

# for masking off modifiers
C.TYPE_MASK = C.BACK - 1

module.exports = C

return unless require.main is module

# I'm lazy tonight.  tests here soon~
