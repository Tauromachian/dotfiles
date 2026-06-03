vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    callback = function()
        local result = vim.system(
            { "git", "branch", "--show-current" },
            { text = true }
        ):wait()

        local branch = ""

        if result.code == 0 then
            branch = vim.trim(result.stdout)
        end

        local branch_name = branch ~= "" and branch or "NoGit"

        vim.o.statusline = "  " .. branch_name .. "  %f %m %r %h %=%l/%L "
    end,
})
