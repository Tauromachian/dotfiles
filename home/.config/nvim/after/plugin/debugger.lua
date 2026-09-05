local mason_dap = require("mason-nvim-dap")
local dap_virtual_text = require("nvim-dap-virtual-text")
local ui = require("dapui")

-- Dap Virtual Text
dap_virtual_text.setup()

mason_dap.setup({
    ensure_installed = { "cppdbg" },
    automatic_installation = true,
    handlers = {
        function(config)
            require("mason-nvim-dap").default_setup(config)
        end,
    },
})

ui.setup()

-- Toggle ui status open or closed
vim.keymap.set('n', "<F5>", ui.toggle)
