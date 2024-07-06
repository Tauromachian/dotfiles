require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { { "prettier", "biome" } },
        react = { "prettier" },
        typescriptreact = { { "prettier", "biome" } },
        javascriptreact = { "prettier" },
        vue = { "prettier" },
        markdown = { "prettier" },
        css = { "prettier" },
        json = { { "prettier", "biome" } },
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
