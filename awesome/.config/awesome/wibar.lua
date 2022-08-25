local screen = _G.screen

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local lain  = require("lain")
-- Widget and layout library
local wibox = require("wibox")

local mymainmenu = require("menu")
local bindings = require("bindings")

local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu.main })

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
                          awful.button({ }, 1, function () awful.layout.inc( 1) end),
                          awful.button({ }, 3, function () awful.layout.inc(-1) end),
                          awful.button({ }, 4, function () awful.layout.inc( 1) end),
                          awful.button({ }, 5, function () awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = bindings.taglist_mouse
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = bindings.tasklist_mouse
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      mykeyboardlayout,
      wibox.widget.systray(),
      mytextclock,
      s.mylayoutbox,
    },
  }

  -- cal
  s.cal = lain.widget.cal({
      attach_to = { mytextclock },
      week_number = "left"
      -- notification_preset = {
      --   font = hotkeys_font_type .. " 9"
      --   fg   = theme.fg_normal,
      --   bg   = theme.bg_normal
  })
  -- -- MEM
  -- local memicon = wibox.widget.imagebox(theme.widget_mem)
  -- local mem = lain.widget.mem({
  --     settings = function()
  --         widget:set_markup(markup.font(theme.font, " " .. string.format("%0.2f", tonumber(mem_now.used) / 953.674) .. "GB "))
  --     end
  -- })
  --
  -- -- CPU
  -- local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
  -- local cpu = lain.widget.cpu({
  --     settings = function()
  --         widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
  --     end
  -- })
  --
  -- -- Coretemp
  -- local tempicon = wibox.widget.imagebox(theme.widget_temp)
  -- if theme.machine_name == 'XPS 13 9380' then
  --     theme.tempfile = '/sys/devices/virtual/thermal/thermal_zone10/temp'
  -- else
  --     theme.tempfile = '/sys/devices/virtual/thermal/thermal_zone0/temp'
  -- end
  -- local temp = lain.widget.temp({
  --     tempfile = theme.tempfile,
  --     settings = function()
  --         widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
  --     end
  -- })

end)
