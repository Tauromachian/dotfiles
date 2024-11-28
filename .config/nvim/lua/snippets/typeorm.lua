local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local typeorm = {
    s('typeCol', {
        t({ '@Column()', '' }),
        i(1, 'columnName'),
        t(':'),
        i(2, 'string'),
        t(';'),
    })
}


return typeorm
