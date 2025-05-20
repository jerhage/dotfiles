return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 5000,
	opts = {
		flavour = "mocha", -- Or "latte", "frappe", "macchiato"
		integrations = {
			cmp = true,
			gitsigns = true,
			treesitter = true,
			notify = true,
			mini = {
				enabled = true,
				indentscope_color = "", -- Leave empty to use default
			},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")

		-- Can configure highlights by doing something like
		-- vim.cmd.hi("Comment gui=none")
	end,
}
