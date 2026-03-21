require("catppuccin").setup({
	flavour = "mocha",
	integrations = {
		cmp = true,
		gitsigns = true,
		treesitter = true,
		notify = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
	},
})
vim.cmd.colorscheme("catppuccin")
