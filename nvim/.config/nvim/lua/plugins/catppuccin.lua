return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "mocha", -- Or "latte", "frappe", "macchiato"
		integrations = {
			cmp = true,
			gitsigns = true,
			treesitter = true,
			notify = true,
			lualine = true,
			mini = {
				enabled = true,
				indentscope_color = "", -- Leave empty to use default
			},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
