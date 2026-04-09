require("catppuccin").setup({
	flavour = "auto", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false, -- disables setting the background color.
	float = {
		transparent = false, -- enable transparent floating windows
		solid = false, -- use solid styling for floating windows, see |winborder|
	},
	term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	},
	lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
		virtual_text = {
			errors = { "italic" },
			hints = { "italic" },
			warnings = { "italic" },
			information = { "italic" },
			ok = { "italic" },
		},
		underlines = {
			errors = { "underline" },
			hints = { "underline" },
			warnings = { "underline" },
			information = { "underline" },
			ok = { "underline" },
		},
		inlay_hints = {
			background = true,
		},
	},
	color_overrides = {},
	custom_highlights = function(colors)
		return {
			-- NormalFloat = { fg = colors.lavender },
			-- NoicePopup = { fg = colors.flamingo },
			-- NoicePopupBorder = { bg = colors.green },
		}
	end,
	default_integrations = true,
	auto_integrations = false,
	integrations = {
		cmp = false,
		gitsigns = true,
		treesitter = true,
		notify = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
	},
})

vim.cmd.colorscheme("catppuccin")

require("colorful-menu").setup({
	ls = {
		lua_ls = {
			-- Maybe you want to dim arguments a bit.
			arguments_hl = "@comment",
		},
		gopls = {
			-- By default, we render variable/function's type in the right most side,
			-- to make them not to crowd together with the original label.

			-- when true:
			-- foo             *Foo
			-- ast         "go/ast"

			-- when false:
			-- foo *Foo
			-- ast "go/ast"
			align_type_to_right = true,
			-- When true, label for field and variable will format like "foo: Foo"
			-- instead of go's original syntax "foo Foo". If align_type_to_right is
			-- true, this option has no effect.
			add_colon_before_type = false,
			-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
			preserve_type_when_truncate = true,
		},
		-- for lsp_config or typescript-tools
		ts_ls = {
			-- false means do not include any extra info,
			-- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
			extra_info_hl = "@comment",
		},
		vtsls = {
			-- false means do not include any extra info,
			-- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
			extra_info_hl = "@comment",
		},
		["rust-analyzer"] = {
			-- Such as (as Iterator), (use std::io).
			extra_info_hl = "@comment",
			-- Similar to the same setting of gopls.
			align_type_to_right = true,
			-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
			preserve_type_when_truncate = true,
		},
		clangd = {
			-- Such as "From <stdio.h>".
			extra_info_hl = "@comment",
			-- Similar to the same setting of gopls.
			align_type_to_right = true,
			-- the hl group of leading dot of "•std::filesystem::permissions(..)"
			import_dot_hl = "@comment",
			-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
			preserve_type_when_truncate = true,
		},
		zls = {
			-- Similar to the same setting of gopls.
			align_type_to_right = true,
		},
		roslyn = {
			extra_info_hl = "@comment",
		},
		dartls = {
			extra_info_hl = "@comment",
		},
		-- The same applies to pyright/pylance
		basedpyright = {
			-- It is usually import path such as "os"
			extra_info_hl = "@comment",
		},
		pylsp = {
			extra_info_hl = "@comment",
			-- Dim the function argument area, which is the main
			-- difference with pyright.
			arguments_hl = "@comment",
		},
		-- If true, try to highlight "not supported" languages.
		fallback = true,
		-- this will be applied to label description for unsupport languages
		fallback_extra_info_hl = "@comment",
	},
	-- If the built-in logic fails to find a suitable highlight group for a label,
	-- this highlight is applied to the label.
	fallback_highlight = "@variable",
	-- If provided, the plugin truncates the final displayed text to
	-- this width (measured in display cells). Any highlights that extend
	-- beyond the truncation point are ignored. When set to a float
	-- between 0 and 1, it'll be treated as percentage of the width of
	-- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
	-- Default 60.
	max_width = 60,
})

-- local function set_float_hl()
-- 	vim.api.nvim_set_hl(0, "NormalFloat", {
-- 		bg = "#1f2335",
-- 		fg = "#c0caf5",
-- 	})
--
-- 	vim.api.nvim_set_hl(0, "FloatBorder", {
-- 		bg = "#1f2335",
-- 		fg = "#7aa2f7",
-- 	})
--
-- 	vim.api.nvim_set_hl(0, "FloatTitle", {
-- 		bg = "#1f2335",
-- 		fg = "#7dcfff",
-- 		bold = true,
-- 	})
-- end
--
-- set_float_hl()
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	callback = set_float_hl,
-- })
