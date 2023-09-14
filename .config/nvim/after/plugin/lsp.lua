local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
  -- Replace these with whatever servers you want to install
    'tsserver',
    'eslint',
    'volar',
    'astro',
    'intelephense'
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
lspconfig.intelephense.setup{}

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

lsp.setup()
