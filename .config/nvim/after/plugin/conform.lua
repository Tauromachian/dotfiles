require("conform").setup({
    formatters_by_ft = {
        -- Use a sub-list to run only the first available formatter
        javascript = { "prettier" },
        typescript = { "prettier" },
        react = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        vue = { "prettier" },
        markdown = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        html = { "prettier" },
        php = { { "pint", "php_cs_fixer" } }
    },

    -- log_level = vim.log.levels.DEBUG,

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 1000,
        lsp_fallback = true,
    },

    -- formatters = {
    --     pint2 = {
    --         command = function()
    --             return './vendor/bin/pint'
    --         end,
    --         args = { vim.fn.expand('%') },
    --         stdin = false
    --     }
    -- }
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.php", -- Adjust the pattern to your filetype
--     command = "!./vendor/bin/pint %",
-- })
