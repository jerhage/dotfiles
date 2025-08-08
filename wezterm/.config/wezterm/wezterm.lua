local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Mocha"
		-- return "Catppuccin Latte"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.font = wezterm.font_with_fallback({
	-- "FiraCode Nerd Font",
	-- { family = "Input Mono", scale = 1.0 },
	-- { family = "FiraCode Nerd Font", scale = 1.0 },
	{ family = "JetBrains Mono", scale = 1.0 },
})
config.font_size = 14.0

-- false because doesn't display properly when true for whatever reason
config.enable_wayland = false

config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.enable_scroll_bar = false
config.window_background_opacity = 1.0
config.warn_about_missing_glyphs = false
config.scrollback_lines = 5000
config.max_fps = 144
config.animation_fps = 144
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Needed for starship to load in new shells automatically
-- Before had to call `exec bash` for each new shell
local is_darwin = wezterm.target_triple:find("darwin") ~= nil
-- local is_linux = wezterm.target_triple:find("linux") ~= nil

config.default_prog = { "/bin/bash" }
if is_darwin then
	config.default_prog = { "/bin/zsh" }
end

-- NOTE: Styling
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.use_fancy_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_max_width = 32
config.colors = {
	tab_bar = {
		active_tab = {
			fg_color = "#073642",
			bg_color = "#2aa198",
		},
	},
}

config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 0.75,
}

config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, pane)
	local ws = window:active_workspace()
	-- local cwd = pane:get_current_working_dir().file_path
	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.dev_terminal .. " " .. ws },
	}))
end)

-- NOTE: Smart Splits configuration

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- NOTE: Keybinds
local function resize_pane(key, dir)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ dir, 3 }),
	}
end

config.leader = { key = " ", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		mods = "LEADER",
	},
	{
		key = "=",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			-- Allows keytable to remain active after handling first keypress
			one_shot = false,
			timeout_milliseconds = 1000,
		}),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		mods = "LEADER",
		key = "f",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = "}",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- activate copy mode or vim mode
	{
		key = "Enter",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	-- Attach to muxer
	{
		key = "a",
		mods = "LEADER",
		action = wezterm.action.AttachDomain("unix"),
	},

	-- Detach from muxer
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action.DetachDomain({ DomainName = "unix" }),
	},
	{
		key = "$",
		mods = "LEADER|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for session",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},
	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "&", -- Characters requiring SHIFT must be accompanied with the SHIFT mod as below
		mods = "LEADER|SHIFT", -- see above why SHIFT is needed
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	-- Show list of workspaces
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),

	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
}

-- For direct navigation to tab by number
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_pane = {
		resize_pane("h", "Left"),
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("l", "Right"),
	},
}
-- NOTE: Workspaces
config.default_workspace = "home"
config.unix_domains = {
	{
		name = "unix",
	},
}

return config
