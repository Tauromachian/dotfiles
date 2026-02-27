local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',

    -- Navigation
    { "ThePrimeagen/harpoon",           branch = "harpoon2", event = "VeryLazy" },
    'nvim-telescope/telescope.nvim',

    -- LSPs and snippets
    'neovim/nvim-lspconfig',
    { "mason-org/mason.nvim",           opts = {} },
    { "mason-org/mason-lspconfig.nvim", opts = {} },

    "rafamadriz/friendly-snippets",
    {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
        build = "make install_jsregexp"
    },

    { 'stevearc/conform.nvim',   event = "BufWritePre" },
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    "hrsh7th/cmp-buffer",
    'saadparwaiz1/cmp_luasnip',

    -- Git
    { 'lewis6991/gitsigns.nvim', event = "BufReadPre" },
    { 'tpope/vim-fugitive',      cmd = { "Git", "G" } },

    -- Utilities
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    {
        'windwp/nvim-ts-autotag',
        event = 'BufReadPre',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- Styles and looks
    { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
    {
        'rebelot/kanagawa.nvim',
        config = function()
            vim.cmd("colorscheme kanagawa")
        end
    },
})
