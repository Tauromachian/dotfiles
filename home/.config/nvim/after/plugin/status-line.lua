vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
    callback = function()
        local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
        -- local branch = vim.fn.system("git branch --show-current err> /dev/null | tr -d '\n'")

        local branch_name = branch == '' and "NoGit" or branch
        vim.o.statusline = '  ' .. branch_name .. ' ' .. " %f %m %r %h   %=%l/%L "
    end
})
