local global = {
    dynamic_theme   = false,
    modkey          = "Mod4",
    -- panel_size      = dpi(50),
    -- panel_position  = "left",
    terminal        = "alacritty",
    editor          = os.getenv("EDITOR") or "nvim",
    -- explorer        = "ranger",
}

global.editor_cmd   = global.terminal .. " -e " .. global.editor
-- global.explorer_cmd = global.terminal .. " -e " .. global.explorer

return global
