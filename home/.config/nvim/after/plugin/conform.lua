require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier", "deno_fmt", stop_after_first = true },
        typescript = { "prettier", "biome", "deno_fmt", stop_after_first = true },
        react = { "prettier" },
        typescriptreact = { "prettier", "biome", stop_after_first = true },
        javascriptreact = { "prettier" },
        vue = { "prettier" },
        markdown = { "prettier" },
        css = { "prettier" },
        json = { "prettier", "biome", "deno_fmt", stop_after_first = true },
        scss = { "prettier" },
        less = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        html = { "prettier", "deno_fmt" },
        php = { "php_cs_fixer" },
        blade = { "blade-formatter" },
    },


    -- log_level = vim.log.levels.DEBUG,

    format_on_save = {
        timeout_ms = 2500,
        lsp_format = "fallback",
    },
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.php", -- Adjust the pattern to your filetype
--     command = "!./vendor/bin/pint %",
-- })
