function _G.Statusline()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

    local branch_name = branch == '' and "NoGit" or branch

    return '  ' .. branch_name .. ' ' .. " %f %m %r %h   %=%l/%L "
end

vim.o.statusline = "%!v:lua.Statusline()"
