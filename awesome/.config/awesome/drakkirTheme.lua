---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}

theme.dir           = os.getenv("HOME") .. "/.config/awesome"
theme.font          = "JetBrainsMono Nerd Font Mono 9"
theme.hotkeys_font  = "JetBrainsMono Nerd Font Mono 9"
theme.hotkeys_description_font  = theme.font

theme.bg_minimize   = "#444444"
theme.bg_normal     = "#282828"
theme.bg_focus      = "#313131"
theme.bg_systray    = theme.bg_normal
theme.bg_urgent     = theme.bg_normal

theme.fg_minimize   = "#ffffff"
theme.fg_normal     = "#ebdbb2"
theme.fg_focus      = "#d79921"
theme.fg_urgent     = "#CC9393"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal)

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.menu_submenu_icon     = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel   = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"

theme.layout_tile           = theme.dir .. "/icons/tile.png"
theme.layout_tileleft       = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom     = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop        = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv          = theme.dir .. "/icons/fairv.png"
theme.layout_fairh          = theme.dir .. "/icons/fairh.png"
theme.layout_spiral         = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle        = theme.dir .. "/icons/dwindle.png"
theme.layout_max            = theme.dir .. "/icons/max.png"
theme.layout_fullscreen     = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier      = theme.dir .. "/icons/magnifier.png"
theme.layout_floating       = theme.dir .. "/icons/floating.png"

theme.widget_ac             = theme.dir .. "/icons/ac.png"
theme.widget_mem            = theme.dir .. "/icons/mem.png"
theme.widget_cpu            = theme.dir .. "/icons/cpu.png"
theme.widget_temp           = theme.dir .. "/icons/temp.png"
theme.widget_wireless_0     = theme.dir .. "/icons/wireless_0.png"
theme.widget_wireless_1     = theme.dir .. "/icons/wireless_1.png"
theme.widget_wireless_2     = theme.dir .. "/icons/wireless_2.png"
theme.widget_wireless_3     = theme.dir .. "/icons/wireless_3.png"
theme.widget_wireless_na    = theme.dir .. "/icons/wireless_na.png"
theme.widget_wired          = theme.dir .. "/icons/wired.png"
theme.widget_wired_na       = theme.dir .. "/icons/wired_na.png"
theme.widget_hdd            = theme.dir .. "/icons/hdd.png"
theme.widget_music          = theme.dir .. "/icons/note.png"
theme.widget_music_on       = theme.dir .. "/icons/note_on.png"
theme.widget_vol            = theme.dir .. "/icons/vol.png"
theme.widget_vol_low        = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no         = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute       = theme.dir .. "/icons/vol_mute.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
