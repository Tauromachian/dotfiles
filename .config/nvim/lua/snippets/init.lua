local ls = require('luasnip') -- Load LuaSnip

local javascript_snippets = require('snippets.javascript')
local vue_snippets = require('snippets.vue')


local function merge(snippets_lists)
    local snippets = {}

    for _, snippets_list in ipairs(snippets_lists) do
        for _, snippet in ipairs(snippets_list) do
            table.insert(snippets, snippet)
        end
    end

    return snippets
end

ls.add_snippets('javascript', javascript_snippets)
ls.add_snippets('vue', { unpack(javascript_snippets), unpack(vue_snippets) })
