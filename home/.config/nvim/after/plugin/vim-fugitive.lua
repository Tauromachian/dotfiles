vim.cmd([[command! -nargs=1 Gc G commit -m <q-args> ]])
vim.cmd([[command! Gca G commit --amend --no-edit ]])
vim.cmd([[command! -nargs=1 Gcam G commit --amend -m <q-args> ]])

vim.keymap.set("n", "<leader>p", ":G push<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>P", ":G pull<CR>", { noremap = true, silent = true })
