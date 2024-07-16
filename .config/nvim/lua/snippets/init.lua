local ls = require('luasnip') -- Load LuaSnip

local javascript_snippets = require('snippets.javascript')
local vue_snippets = require('snippets.vue')

ls.add_snippets('javascript', javascript_snippets)
ls.add_snippets('vue', { unpack(javascript_snippets), unpack(vue_snippets) })
