local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
  -- Replace these with whatever servers you want to install
    'tsserver',
    'eslint',
    'volar',
    'astro'
})


local cmp = require('cmp')

cmp.setup({
    -- Preselect first item from autocompletion
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    -- Sets the key Enter to select completion
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = false}),
    }
})


local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
