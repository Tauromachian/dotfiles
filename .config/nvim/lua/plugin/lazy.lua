local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'nvim-lua/plenary.nvim',

    -- Navigation
    'nvim-tree/nvim-tree.lua',
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    'ThePrimeagen/harpoon',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- LSPs and snippets
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { "rafamadriz/friendly-snippets" },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    { 'saadparwaiz1/cmp_luasnip' },
    {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
        build = "make install_jsregexp"
    },

    -- Git
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'stevearc/conform.nvim',
        opts = {},
    },
    { 'echasnovski/mini.comment', version = '*' },
    'windwp/nvim-autopairs',
    'tpope/vim-surround',

    'nvim-treesitter/nvim-treesitter',
    'rebelot/kanagawa.nvim'
})
