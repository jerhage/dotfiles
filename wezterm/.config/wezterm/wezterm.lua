local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_scroll_bar = true
config.font = wezterm.font("FiraCode Nerd Font Mono")
-- config.font = wezterm.font("FiraMono Nerd Font")
-- config.font = wezterm.font("JetBrains Mono")
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_background_opacity = 0.7
config.warn_about_missing_glyphs = false
config.default_prog = { "/bin/bash" }
-- config.default_prog = { "/bin/bash", "-l" }
return config
