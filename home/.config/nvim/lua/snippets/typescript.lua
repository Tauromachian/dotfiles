local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local typescript = {
    s("async =>", {
        t("async ("),
        i(1, 'parameter'),
        t(")"),
        t("=>"),
        i(2, ''),
    }),
    s("=>", {
        t("("),
        i(1, 'parameter'),
        t(")"),
        t("=>"),
        i(2, ''),
    }),
    s("const var =>", {
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
    s("type", {
        i(1, 'export '),
        t("type "),
        i(2, 'name'),
        t({ "= {", '' }),
        i(3, '// definition'),
        t({ '', "}" })
    }),
    s('cl', {
        t('console.log('),
        i(1, ''),
        t(')'),
    }),
    s("cw", {
        t("console.warn("),
        i(1, ''),
        t(")"),
    }),
    s("ce", {
        t("console.warn("),
        i(1, ''),
        t(")"),
    }),
}

return typescript
