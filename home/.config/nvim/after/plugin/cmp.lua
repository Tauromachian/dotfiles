local luasnip = require('luasnip')
local cmp = require('cmp')

local function luasnip_jump(index)
    return cmp.mapping(function(fallback)
        if luasnip.jumpable(index) then
            luasnip.jump(index)
        else
            fallback()
        end
    end, { 'i', 's' })
end

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
    if require('luasnip').choice_active() then
        require('luasnip').change_choice(1) -- forward
    end
end)

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
    if require('luasnip').choice_active() then
        require('luasnip').change_choice(-1) -- backward
    end
end)

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' }
    },

    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },

    -- Preselect first item from autocompletion
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },

    -- Sets simple autocompletion keybindings
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = luasnip_jump(1),
        ['<S-Tab>'] = luasnip_jump(-1),
    })
})
