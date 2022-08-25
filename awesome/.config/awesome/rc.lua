-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

require("error_handling")
require("theme")
require("bindings")
require("wibar")
require("rules")
require("signal")

-- Startup applications
-- awful.spawn.once("picom --experimental-backends")
