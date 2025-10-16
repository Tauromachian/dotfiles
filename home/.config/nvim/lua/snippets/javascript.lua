local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local javascript = {
    s("=>", {
        i(1, "async "),
        t("("),
        i(2, 'parameter'),
        t(")"),
        t("=>"),
        i(3, ''),
    }),
    s("=>2", {
        t('const '),
        i(1, 'name'),
        t('='),
        i(2, 'async '),
        t('('),
        i(3, 'parameter'),
        t(')'),
        t('=>'),
        i(4, ''),
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
        i(5, ''),
        t("}"),
    }),
    s("cw", {
        t("console.warn("),
        i(1, ''),
        t(")"),
    }),
    s("method", {
        i(1, "async "),
        i(2, "name "),
        t("("),
        i(3, "argument"),
        t({ ") {", '' }),
        i(4, ""),
        ({ "", "}" }),
    })
}

return javascript
