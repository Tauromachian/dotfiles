local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

local typeorm = {
    s('typeCol', fmt([[
    @Column()
    {col}:{typ};
    ]], {
        col = i(1, 'columnName'),
        typ = i(2, 'string'),
    })),
    s('typeManyToOne', fmt([[
    @ManyToOne(() => {ent}, ({e}: {entRep}) => {eRep}.{ret})
    @JoinColumn({{ name: '{eRep2}Id' }})
    {eRep3}:{entRep2};
    ]], {
        ent = i(1, 'EntityName'),
        e = i(2, 'entity'),
        entRep = rep(1),
        eRep = rep(2),
        ret = i(3, 'return'),
        eRep2 = rep(2),
        eRep3 = rep(2),
        entRep2 = rep(1),
    })),
    s('typeOneToMany', fmt([[
    @OneToMany(() => {ent}, ({e}: {entRep}) => {eRep}.{ret})
    {eRep2}:{entRep2}[];
    ]], {
        ent = i(1, 'EntityName'),
        e = i(2, 'entity'),
        entRep = rep(1),
        eRep = rep(2),
        ret = i(3, 'return'),
        eRep2 = rep(2),
        entRep2 = rep(1),
    })),
}

return typeorm
