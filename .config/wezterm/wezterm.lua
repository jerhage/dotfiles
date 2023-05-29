local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_scroll_bar=true
config.font = wezterm.font 'JetBrains Mono Nerd Font'


return config
