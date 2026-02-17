local luasnip = require('luasnip')
local cmp = require('cmp')

require('luasnip.loaders.from_vscode').lazy_load()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'eslint', 'emmet_ls', 'tailwindcss', 'ts_ls', 'vue_ls' },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" } }
        }
    }
})

vim.lsp.config['denols'] = {
    root_markers = { 'deno.json' }
}

vim.lsp.config['tailwindcss'] = {
    root_markers = { 'tailwind.config.js' }
}

local mason_root = require("mason.settings").current.install_root_dir
local vue_typescript_plugin = mason_root .. '/node_modules/@vue/typescript-plugin'

vim.lsp.config['ts_ls'] = {
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
    root_markers = { 'package.json' },
    single_file_support = false,
}

local function luasnip_jump(index)
    return cmp.mapping(function(fallback)
        if luasnip.jumpable(index) then
            luasnip.jump(index)
        else
            fallback()
        end
    end, { 'i', 's' })
end

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' }
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
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

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

        vim.keymap.set('n', '<leader>ep', vim.diagnostic.open_float, { silent = true })
        vim.keymap.set('n', '<leader>ec', vim.diagnostic.setqflist, { silent = true })
        vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { silent = true })
        vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { silent = true })
    end,
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰌶",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
})
