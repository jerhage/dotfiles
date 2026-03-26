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
		cmp = true,
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

vim.cmd.colorscheme("catppuccin-nvim")

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
