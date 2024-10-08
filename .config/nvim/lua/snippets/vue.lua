local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local vue_scripts = {
    s("vProp", {
        i(1, 'name'),
        t(":"),
        t("{"),
        t("type:"),
        i(2, 'String'),
        t(","),
        t("default:"),
        i(3, '""'),
        t("}"),
    }),
    s("vComputed", {
        i(1, 'const '),
        i(2, 'name'),
        t("= computed(() => {)"),
        i(3, '// content'),
        t("}"),
    }),
    s("vComputed2", {
        i(1, 'const '),
        i(2, 'name'),
        t({ "= computed({", "get () {", "return" }),
        i(3, '// return'),
        t({ "},", "set (val) {", "emit('" }),
        i(4, "update:val"),
        t("', val)"),
        t({ "}", "})" }),
    }),
    s("defineModel", {
        t('const '),
        i(1, 'name'),
        t({ "= defineModel({", "type:" }),
        i(2, 'String'),
        t({ "", ",", "default:" }),
        i(3, '""'),
        t({ "", "})" }),
    }),
}

return vue_scripts
