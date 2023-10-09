local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tgf', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- The code bellow opens in nvim tree the file location after the same is found in telescope
local actions = require('telescope.actions')
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
    },
}
