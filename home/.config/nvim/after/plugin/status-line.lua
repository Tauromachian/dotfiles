require("lualine").setup {
    sections = {
        lualine_b = {
            {
                'branch',
                fmt = function(str)
                    if str:len() > 14 then
                        return str:sub(1, 15) .. '...'
                    end
                    return str
                end,
            },
            {
                'diff'
            }
        },
        lualine_x = {},
    }
}
