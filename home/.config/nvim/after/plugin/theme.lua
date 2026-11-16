-- Auto light/dark theme to match Ghostty / OS color-scheme.
-- Ghostty already flips its own colors via `theme = light:...,dark:...`,
-- so here we flip Neovim the same way: OS theme -> background + kanagawa variant.

local function system_theme()
    -- 1. GNOME / GTK (covers Omarchy/Hyprland with xdg-desktop-portal-gtk).
    if vim.fn.executable("gsettings") == 1 then
        local out = vim.fn.system({ "gsettings", "get", "org.gnome.desktop.interface", "color-scheme" })
        if vim.v.shell_error == 0 then
            if out:match("prefer%-dark") then
                return "dark"
            elseif out:match("prefer%-light") or out:match("default") then
                return "light"
            end
        end
    end

    -- 2. macOS system appearance.
    if vim.fn.has("mac") == 1 and vim.fn.executable("defaults") == 1 then
        local out = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
        if vim.v.shell_error == 0 and out:match("Dark") then
            return "dark"
        else
            return "light"
        end
    end

    -- 3. Terminal hint: COLORFGBG is "fg;bg", bg 0-6 is dark, 7-15 is light.
    local colorfgbg = vim.env.COLORFGBG
    if colorfgbg then
        local bg = tonumber(colorfgbg:match("(%d+)%s*$"))
        if bg then
            return bg <= 6 and "dark" or "light"
        end
    end

    return nil
end

local function apply_theme()
    local want = system_theme()
    if not want then
        return
    end
    if vim.o.background == want then
        return
    end
    vim.o.background = want
    if want == "light" then
        pcall(vim.cmd.colorscheme, "kanagawa-lotus")
    else
        pcall(vim.cmd.colorscheme, "kanagawa")
    end
end

-- Apply once on startup (after/ runs after lazy.lua sets the default).
apply_theme()

local group = vim.api.nvim_create_augroup("auto-system-theme", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
    group = group,
    callback = apply_theme,
})

-- Poll so an already-open Neovim flips when the OS/Ghostty theme changes.
local uv = vim.uv or vim.loop
if uv then
    local timer = uv.new_timer()
    if timer then
        timer:start(5000, 5000, vim.schedule_wrap(apply_theme))
    end
end

vim.keymap.set('n', '<leader>cl', "<cmd>:colorscheme kanagawa-lotus<CR>")
vim.keymap.set('n', '<leader>cd', "<cmd>:colorscheme kanagawa-wave<CR>")
vim.keymap.set('n', '<leader>cb', "<cmd>:colorscheme kanagawa-wave<CR>")
