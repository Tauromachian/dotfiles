local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    'tsserver',
    'eslint',
    'volar',
    'astro',
    'intelephense',
    'html',
    'emmet_ls'
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
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }
})


local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.intelephense.setup {
    filetypes = { 'php' }
}
lspconfig.volar.setup {
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end
}

lspconfig.eslint.setup {
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end
}

lspconfig.emmet_ls.setup {
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end
}

local clients_excluded_for_format = {
    tsserver = true,
    eslint = true,
    volar = true,
    astro = true,
    html = true,
    emmet_ls = true
}

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })

    vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
            if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
                return
            end

            local can_format = not clients_excluded_for_format[client.name]

            if can_format then
                vim.lsp.buf.format()
            end
        end
    })
end)


lsp.setup()
