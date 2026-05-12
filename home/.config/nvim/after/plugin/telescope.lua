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
        preview = {
            filetype_hook = function(filepath, bufnr, opts)
                local excluded = { svg = true }
                local ext = filepath:match("%.(%w+)$")
                if ext and excluded[ext:lower()] then
                    require("telescope.previewers.utils").set_preview_message(
                        bufnr,
                        opts.winid,
                        string.format("Preview disabled for .%s files", ext)
                    )
                    return false
                end
                return true
            end,
        },
        mappings = {
            i = {
                ["<c-d>"] = actions.delete_buffer,
                ['<c-n>'] = actions.cycle_history_next,
                ['<c-p>'] = actions.cycle_history_prev,
            },
            n = {
                ["<c-d>"] = actions.delete_buffer,
                ['dd'] = actions.delete_buffer,
                ['<c-n>'] = actions.cycle_history_next,
                ['<c-p>'] = actions.cycle_history_prev,
            },
        },
    },
}
