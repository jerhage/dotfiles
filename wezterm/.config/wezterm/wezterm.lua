local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_scroll_bar=true
config.font = wezterm.font 'JetBrains Mono Nerd Font'
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_background_opacity = 0.7

return config
