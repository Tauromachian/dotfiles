local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ts', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<CR>"] = function(prompt_bufnr)
                    actions.select_default(prompt_bufnr)
                    vim.cmd(":NvimTreeFindFile")
                    vim.api.nvim_input('<CR>')
                    vim.cmd(":NvimTreeCollapseKeepBuffers")
                end,
            },
        },
    },
}
