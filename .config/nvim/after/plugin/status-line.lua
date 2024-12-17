require("lualine").setup {
    extensions = { 'nvim-tree' },
    sections = {
        lualine_b = {
            {
                'branch', 'diff', 'diagnostics',
                fmt = function(str)
                    if str:len() > 14 then
                        return str:sub(1, 15) .. '...'
                    end
                    return str
                end,
            }
        },
        lualine_x = {},
    }
}
