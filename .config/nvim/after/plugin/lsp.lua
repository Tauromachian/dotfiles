local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' }
    },

    -- Preselect first item from autocompletion
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },

    -- Sets simple autocompletion keybindings
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp_action.luasnip_jump_forward(),
        ['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
    }
})

lsp.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })

    vim.api.nvim_set_keymap('n', '<leader>ep', '<cmd>lua vim.diagnostic.open_float()<CR>',
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
end)

local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local nvim_lsp = require('lspconfig')

nvim_lsp.tailwindcss.setup {
    root_dir = nvim_lsp.util.root_pattern("tailwind"),
}

local vue_typescript_plugin = require('mason-registry')
    .get_package('vue-language-server')
    :get_install_path()
    .. '/node_modules/@vue/language-server'
    .. '/node_modules/@vue/typescript-plugin'

nvim_lsp.ts_ls.setup {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_typescript_plugin,
                languages = { 'javascript', 'typescript', 'vue' }
            },
        }
    },
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
    root_dir = nvim_lsp.util.root_pattern("package.json"),
    single_file_support = false,
}

nvim_lsp.denols.setup {
    root_dir = nvim_lsp.util.root_pattern("deno.json"),
}
