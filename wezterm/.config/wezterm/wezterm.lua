local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_scroll_bar = true
config.font = wezterm.font("FiraCode")
config.font_size = 14.0
-- config.font = wezterm.font("FiraMono Nerd Font")
-- config.font = wezterm.font("JetBrains Mono")
-- config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_background_opacity = 0.7
config.warn_about_missing_glyphs = false
-- Needed for starship to load in new shells automatically
-- Before had to call `exec bash` for each new shell
config.default_prog = { "/bin/bash" }
return config
