-- Theme handling library
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Themes define colours, icons and  font
beautiful.init(gears.filesystem.get_configuration_dir() .. "drakkirTheme.lua")

-- override theme
beautiful.wallpaper = "/usr/share/backgrounds/drakkir/3287c539ac9f9178779ded613c2c3009a33e1afbf06350ede657a94d794ab0e986ce.png"
beautiful.useless_gap = dpi(5)
beautiful.gap_single_client = true
beautiful.border_width = 2

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
}
