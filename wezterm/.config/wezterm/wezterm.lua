local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.font = wezterm.font_with_fallback({
	"FiraCode",
	"JetBrains Mono",
})
config.font_size = 14.0

config.window_decorations = "NONE"
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_background_opacity = 1.0
config.warn_about_missing_glyphs = false
-- Needed for starship to load in new shells automatically
-- Before had to call `exec bash` for each new shell
config.default_prog = { "/bin/bash" }
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
