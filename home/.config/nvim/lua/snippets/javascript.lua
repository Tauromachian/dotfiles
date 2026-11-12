local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

local javascript = {
    s("async =>", fmt("async ({param}) => {body}", {
        param = i(1, 'parameter'),
        body = i(2),
    })),
    s('=>', fmt('({arg}) => {def}', {
        arg = i(1, ''),
        def = i(2, '')
    })),
    s("const var =>", fmt("const {name} = {async}({param}) => {body}", {
        name = i(1, 'name'),
        async = i(2, 'async '),
        param = i(3, 'parameter'),
        body = i(4),
    })),
    s("func", fmt("{export}{async}function {name}({param}) {{{body}}}", {
        export = i(1, 'export '),
        async = i(2, 'async '),
        name = i(3, 'name'),
        param = i(4, 'parameter'),
        body = i(5),
    })),
    s("cw", fmt("console.warn({val})", {
        val = i(1),
    })),
    s("ce", fmt("console.error({val})", {
        val = i(1),
    })),
    s("method", fmt([[
    {async}{name}({arg}) {{
      {body}
    }}
    ]], {
        async = i(1, "async "),
        name = i(2, "name"),
        arg = i(3, "argument"),
        body = i(4),
    })),
    s('fetch', fmt([[
    const res = await fetch({url});
    const data = await res.json();
    {last}
    ]], {
        url = i(1, 'url'),
        last = i(0)
    }))
}

return javascript
