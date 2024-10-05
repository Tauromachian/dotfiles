require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "javascript", "typescript", "php", "yaml", "astro", "vue", "html" },

    indent = { enable = true },

    -- automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        enable = true,
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "blade",
}

vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})

-- vim.treesitter.query.set("blade", "injections", "(comment) @comment")
