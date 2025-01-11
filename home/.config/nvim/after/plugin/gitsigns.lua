require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gs.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gs.nav_hunk('prev')
            end
        end)


        -- Actions
        map('n', '<leader>gs', gs.stage_hunk)
        map('n', '<leader>gr', gs.reset_hunk)
        map('n', '<leader>gS', gs.stage_buffer)
        map('n', '<leader>gR', gs.reset_buffer)
        map('n', '<leader>gu', gs.undo_stage_hunk)
        map('n', '<leader>gp', gs.preview_hunk)
        map('n', '<leader>gb', gs.toggle_current_line_blame)
        map('n', '<leader>gd', gs.diffthis)
        map('n', '<leader>gD', function() gs.diffthis('~') end)
    end
}
