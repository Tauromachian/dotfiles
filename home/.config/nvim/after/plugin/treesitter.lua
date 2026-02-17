require 'nvim-treesitter'.setup {
    ensure_installed = { "lua", "javascript", "typescript", "php", "yaml", "astro", "vue", "html" },

    indent = { enable = true },

    -- automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        enable = true,
    },
}
