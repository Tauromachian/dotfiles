vim.o.termguicolors = true
vim.opt.signcolumn = 'yes'

vim.g.mapleader = " "

vim.g.loaded_matchit = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")

vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>d", "\"_d")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking",
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})


vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    desc = 'Attach keymaps for quickfix list',
    callback = function()
        vim.keymap.set('n', 'dd', function()
            local qf_list = vim.fn.getqflist()

            local current_line = vim.fn.line('.')

            if qf_list[current_line] then
                table.remove(qf_list, current_line)

                vim.fn.setqflist(qf_list, 'r')

                local new_line = math.min(current_line, #qf_list)
                vim.fn.cursor(new_line, 1)
            end
        end, {
            buffer = true,
            silent = true,
            desc = 'Remove quickfix item under cursor',
        })
    end
})

require("config.lazy")

local ok, _ = pcall(require, 'luasnip')

if ok then
    require("snippets")
end
