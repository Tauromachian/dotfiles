local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

local tsx = {
    s('rUseState', fmt('const [{var}, {setter}] = useState<{typ}>({default})', {
        var = i(1, 'var'),
        setter = f(function(args)
            return 'set' .. args[1][1]:gsub('^%l', string.upper)
        end, { 1 }),
        typ = i(2, 'Type'),
        default = i(3, ''),
    }))
}

return tsx
