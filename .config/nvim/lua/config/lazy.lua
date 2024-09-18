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

    -- Navigation
    'nvim-tree/nvim-tree.lua',
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- LSPs and snippets
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    'neovim/nvim-lspconfig',

    "rafamadriz/friendly-snippets",
    {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
        build = "make install_jsregexp"
    },
    {
        'stevearc/conform.nvim',
        opts = {},
    },

    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    "hrsh7th/cmp-buffer",
    'saadparwaiz1/cmp_luasnip',

    {
        'Exafunction/codeium.vim',
        event = 'BufEnter'
    },

    -- Git
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',

    -- Utilities
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    'tpope/vim-surround',

    -- Styles and looks
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    'rebelot/kanagawa.nvim',
})
