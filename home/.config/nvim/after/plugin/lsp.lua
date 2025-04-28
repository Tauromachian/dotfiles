local luasnip = require('luasnip')
local cmp = require('cmp')
local lspconfig = require('lspconfig')

require('luasnip.loaders.from_vscode').lazy_load()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'eslint', 'emmet_ls', 'tailwindcss', 'ts_ls' },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup {}
        end,
        ['denols'] = function()
            lspconfig.denols.setup {
                root_dir = lspconfig.util.root_pattern("deno.json"),
            }
        end,
        ['lua_ls'] = function()
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    },
                },
            }
        end,
        ['tailwindcss'] = function()
            lspconfig.tailwindcss.setup {
                root_dir = lspconfig.util.root_pattern("tailwind"),
            }
        end,
        ['ts_ls'] = function()
            local vue_typescript_plugin = require('mason-registry')
                .get_package('vue-language-server')
                :get_install_path()
                .. '/node_modules/@vue/language-server'
                .. '/node_modules/@vue/typescript-plugin'


            lspconfig.ts_ls.setup {
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
                root_dir = lspconfig.util.root_pattern("package.json"),
                single_file_support = false,
            }
        end
    },
})

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
