vim.cmd([[command! -nargs=1 Gc G commit -m <q-args> ]])
vim.cmd([[command! -nargs=1 Gca G commit --amend --no-edit ]])
