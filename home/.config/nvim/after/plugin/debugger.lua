local mason_dap = require("mason-nvim-dap")
local dap_virtual_text = require("nvim-dap-virtual-text")
local ui = require("dapui")
local dap = require('dap')

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

dap.adapters['pwa-node'] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        -- Path when installed via Mason:
        args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
        },
    },
}

-- Configurations for JavaScript & TypeScript
local js_based_languages = { "typescript", "javascript" }

for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
        -- Launch the current file
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${fileDirname}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        -- Attach to a running Node process
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        -- Debug Jest tests (common extra)
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
    }
end

ui.setup()
vim.fn.sign_define("DapBreakpoint", { text = "󰨰" })

-- Toggle ui status open or closed
vim.keymap.set('n', "<F9>", dap.toggle_breakpoint)
vim.keymap.set('n', "<F10>", dap.continue)
vim.keymap.set('n', "<F5>", ui.toggle)
