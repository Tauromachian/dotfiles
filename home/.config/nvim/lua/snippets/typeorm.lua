local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

local typeorm = {
    s('typeCol', {
        t({ '@Column()', '' }),
        i(1, 'columnName'),
        t(':'),
        i(2, 'string'),
        t(';'),
    }),
    s('typeManyToOne', {
        t("@ManyToOne(() =>"),
        i(1, 'EntityName'),
        t(', ('),
        i(2, 'entity'),
        t(':'),
        rep(1),
        t(') =>'),
        rep(2),
        t('.'),
        i(3, 'return'),
        t({ ')', '' }),
        t("@JoinColumn({ name: '"),
        rep(2),
        t({ "Id' })", '' }),
        rep(2),
        t(':'),
        rep(1),
        t(';'),
    }),
    s('typeOneToMany', {
        t("@OneToMany(() =>"),
        i(1, 'EntityName'),
        t(', ('),
        i(2, 'entity'),
        t(':'),
        rep(1),
        t(') =>'),
        rep(2),
        t('.'),
        i(3, 'return'),
        t({ ')', '' }),
        rep(2),
        t(':'),
        rep(1),
        t('[]'),
        t(';'),
    })

}


return typeorm
