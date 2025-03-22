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

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
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
        ['<Tab>'] = cmp_action.luasnip_jump_forward(),
        ['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
    })
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

        vim.keymap.set('n', '<leader>ep', vim.diagnostic.open_float, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ec', vim.diagnostic.setqflist, { noremap = true, silent = true })
        vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { noremap = true, silent = true })
        vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { noremap = true, silent = true })
    end,
})

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
