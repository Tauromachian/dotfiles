local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local typescript = {
    s('cl', {
        t('console.log('),
        i(1, ''),
        t(')'),
    }),
    s("=>", {
        i(1, "async "),
        t("("),
        i(2, 'parameter'),
        t(")"),
        t("=>"),
        i(3, 'content'),
    }),
    s("func", {
        i(1, 'export '),
        i(2, 'async '),
        t("function "),
        i(3, 'name'),
        t("("),
        i(4, 'parameter'),
        t(") "),
        t("{"),
        i(5, 'content'),
        t("}"),
    }),
}

return typescript
