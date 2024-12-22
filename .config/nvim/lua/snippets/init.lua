local ls = require('luasnip') -- Load LuaSnip

local javascript_snippets = require('snippets.javascript')
local vue_snippets = require('snippets.vue')
local typescript_snippets = require('snippets.typescript')
local typeorm_snippets = require("snippets.typeorm")

local function merge(snippets_lists)
    local snippets = {}

    for _, snippets_list in ipairs(snippets_lists) do
        for _, snippet in ipairs(snippets_list) do
            table.insert(snippets, snippet)
        end
    end

    return snippets
end

ls.add_snippets('typescriptreact', typescript_snippets)
ls.add_snippets('javascript', javascript_snippets)
ls.add_snippets('typescript', merge({ typescript_snippets, typeorm_snippets }))
ls.add_snippets('vue', merge({ vue_snippets, javascript_snippets }))
