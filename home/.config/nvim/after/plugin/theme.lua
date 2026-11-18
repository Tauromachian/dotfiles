-- Auto light/dark theme to match Ghostty / OS color-scheme.
-- Ghostty already flips its own colors via `theme = light:...,dark:...`,
-- so here we flip Neovim the same way: OS theme -> background + kanagawa variant.

local function portal_theme()
    -- Most reliable cross-desktop source (GNOME, Cinnamon, Hyprland via
    -- xdg-desktop-portal). 0 = no preference, 1 = prefer dark, 2 = prefer light.
    if vim.fn.executable("gdbus") == 1 then
        local out = vim.fn.system({
            "gdbus", "call", "--session",
            "--dest", "org.freedesktop.portal.Desktop",
            "--object-path", "/org/freedesktop/portal/desktop",
            "--method", "org.freedesktop.portal.Settings.Read",
            "org.freedesktop.appearance", "color-scheme",
        })
        if vim.v.shell_error == 0 then
            if out:match("uint32%s+1") then
                return "dark"
            elseif out:match("uint32%s+2") then
                return "light"
            end
        end
    end

    if vim.fn.executable("busctl") == 1 then
        local out = vim.fn.system({
            "busctl", "--user", "call",
            "org.freedesktop.portal.Desktop",
            "/org/freedesktop/portal/desktop",
            "org.freedesktop.portal.Settings", "Read", "ss",
            "org.freedesktop.appearance", "color-scheme",
        })
        if vim.v.shell_error == 0 then
            -- Output looks like: v v u 1
            local val = out:match("(%d+)%s*$")
            if val == "1" then
                return "dark"
            elseif val == "2" then
                return "light"
            end
        end
    end

    return nil
end

local function gtk_theme_hint()
    -- Fallback for Cinnamon / GNOME where the portal is unavailable.
    -- Theme names containing "dark" (e.g. Mint-Y-Dark-Aqua) mean dark mode.
    local themes = {}
    if vim.fn.executable("gsettings") == 1 then
        for _, key in ipairs({
            { "org.cinnamon.desktop.interface", "gtk-theme" },
            { "org.gnome.desktop.interface",    "gtk-theme" },
            { "org.cinnamon.theme",             "name" },
        }) do
            local out = vim.fn.system({ "gsettings", "get", key[1], key[2] })
            if vim.v.shell_error == 0 and out then
                table.insert(themes, out:lower())
            end
        end
    end
    for _, t in ipairs(themes) do
        if t:match("dark") then
            return "dark"
        end
    end
    return nil
end

local function system_theme()
    -- 1. Desktop portal: authoritative on Cinnamon/GNOME/Hyprland.
    local portal = portal_theme()
    if portal then
        return portal
    end

    -- 2. GNOME / GTK color-scheme. NOTE: 'default' means "unmanaged", NOT
    -- light (e.g. Cinnamon always reports 'default'), so fall through.
    if vim.fn.executable("gsettings") == 1 then
        local out = vim.fn.system({ "gsettings", "get", "org.gnome.desktop.interface", "color-scheme" })
        if vim.v.shell_error == 0 then
            if out:match("prefer%-dark") then
                return "dark"
            elseif out:match("prefer%-light") then
                return "light"
            end
        end
    end

    -- 3. macOS system appearance.
    if vim.fn.has("mac") == 1 and vim.fn.executable("defaults") == 1 then
        local out = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
        if vim.v.shell_error == 0 then
            if out:match("Dark") then
                return "dark"
            end
            -- Absence of AppleInterfaceStyle means light mode, but only
            -- trust it when the command actually succeeded.
            return "light"
        end
    end

    -- 4. GTK / Cinnamon theme name hint (e.g. Mint-Y-Dark-Aqua).
    local gtk = gtk_theme_hint()
    if gtk then
        return gtk
    end

    -- 5. Terminal hint: COLORFGBG is "fg;bg", bg 0-6 is dark, 7-15 is light.
    local colorfgbg = vim.env.COLORFGBG
    if colorfgbg then
        local bg = tonumber(colorfgbg:match("(%d+)%s*$"))
        if bg then
            return bg <= 6 and "dark" or "light"
        end
    end

    return nil
end

-- Manual override: <leader>cl / <leader>cd lock the theme until <leader>ca
-- re-enables auto-follow. Without this the 5s poll would revert a manual
-- choice on the next tick (which also looked like "stuck in light mode").
local manual_override = nil
local last_applied = nil

local function set_scheme(want)
    vim.o.background = want
    if want == "light" then
        pcall(vim.cmd.colorscheme, "kanagawa-lotus")
    else
        -- Explicit wave to match Ghostty's `dark:Kanagawa Wave`.
        pcall(vim.cmd.colorscheme, "kanagawa-wave")
    end
end

local function apply_theme()
    if manual_override then
        return
    end
    local want = system_theme()
    if not want then
        return
    end
    -- NOTE: kanagawa always sets colors_name="kanagawa" regardless of
    -- variant (wave/lotus), so it can't be used to detect the active
    -- variant. Track what we applied instead.
    if vim.o.background == want and last_applied == want then
        return
    end
    set_scheme(want)
    last_applied = want
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
        _G._auto_system_theme_timer = timer -- keep a ref so it isn't GC'd
        timer:start(5000, 5000, vim.schedule_wrap(apply_theme))
    end
end

vim.keymap.set('n', '<leader>cl', function()
    manual_override = "light"
    set_scheme("light")
    last_applied = "light"
    vim.notify("Theme locked: light (use <leader>ca for auto)")
end, { desc = "Lock light theme" })
vim.keymap.set('n', '<leader>cd', function()
    manual_override = "dark"
    set_scheme("dark")
    last_applied = "dark"
    vim.notify("Theme locked: dark (use <leader>ca for auto)")
end, { desc = "Lock dark theme" })
vim.keymap.set('n', '<leader>cb', function()
    manual_override = "dark"
    set_scheme("dark")
    last_applied = "dark"
    vim.notify("Theme locked: dark (use <leader>ca for auto)")
end, { desc = "Lock dark theme" })
vim.keymap.set('n', '<leader>ca', function()
    manual_override = nil
    apply_theme()
    vim.notify("Theme: auto-follow system")
end, { desc = "Auto-follow system theme" })
