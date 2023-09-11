vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- GLOBALS
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Icons for other plugins to use
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'

    -- UTILS --
    -- This is similar to what Ctrl - P does for VSCode
    use {
	    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    }
    -- Code highligting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- Code autocompletion and other features
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
        -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }
    -- Both packages handle autoclosing pairs like () or {}
    use 'tpope/vim-surround'
    use "windwp/nvim-autopairs"

    -- GIT
    -- Git helper. It:
    -- Shows lines that have been changed.
    -- Gives you a way to stage changes right on the spot
    use 'tanvirtin/vgit.nvim'
    -- Adds a visuals to handle changes
    -- Also gives all git commands inside Neovim
    use 'tpope/vim-fugitive'

    -- VISUALS --
    -- A pretty and useful status line
    use 'nvim-lualine/lualine.nvim'
    -- Theme
    use 'rebelot/kanagawa.nvim'
    -- Visual helper for the buffers (shows them as tabs)
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
    }
    -- Shows files sidebar
    use 'nvim-tree/nvim-tree.lua'
end)
