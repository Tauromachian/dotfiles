local bufferline = require('bufferline')

bufferline.setup {
    options = {
        numbers = 'buffer_id',
        always_show_bufferline = false,
        show_buffer_icons = true,
        color_icons = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",

                separator = true
            }
        },

    }
}


