local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

-- This function allows to close buffers on the buffer search.
local buffer_searcher
buffer_searcher = function()
    builtin.buffers {
        sort_mru = true,
        ignore_current_buffer = true,
        show_all_buffers = false,
    }
end

vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({ hidden = true })
end, {})
vim.keymap.set('n', '<leader>fg', function()
    builtin.live_grep({ additional_args = { "--hidden", "--glob", "!.git/*" } })
end, {})

vim.keymap.set('n', '<leader>fc', builtin.quickfix, { silent = true })
vim.keymap.set('n', '<leader>ft', builtin.colorscheme, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-_>', buffer_searcher, { silent = true })

-- The code bellow opens in nvim tree the file location after the same is found in telescope
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<c-d>"] = actions.delete_buffer,
            },
            n = {
                ["<c-d>"] = actions.delete_buffer,
                ['dd'] = actions.delete_buffer
            },
        },
    },
}
