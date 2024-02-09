local builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

-- This function allows to close buffers on the buffer search.
local buffer_searcher
buffer_searcher = function()
    builtin.buffers {
        sort_mru = true,
        ignore_current_buffer = true,
        show_all_buffers = false,
        attach_mappings = function(prompt_bufnr, map)
            local delete_buf = function()
                local selection = action_state.get_selected_entry()
                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                actions.close(prompt_bufnr)
                vim.schedule(buffer_searcher)
            end

            -- this is just an example
            map('n', 'dd', delete_buf)

            return true
        end
    }
end

vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tb', buffer_searcher, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- The code bellow opens in nvim tree the file location after the same is found in telescope
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<CR>"] = function(prompt_bufnr)
                    actions.select_default(prompt_bufnr)
                    vim.cmd(":NvimTreeFindFile")
                    vim.api.nvim_input('<CR>')
                    vim.cmd(":NvimTreeClose")
                end,
            },
        },
        layout_strategy = vim.o.lines > 70 and 'vertical' or 'horizontal',
    },
}
