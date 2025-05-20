return {
	"NeogitOrg/neogit",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",

		-- Only one of these is needed.
		-- "nvim-telescope/telescope.nvim",
		-- "ibhagwan/fzf-lua",
		-- "echasnovski/mini.pick",
		"folke/snacks.nvim",
	},
	config = function()
		local neogit = require("neogit")
		neogit.setup({})

		vim.keymap.set("n", "<leader>N", "<cmd>Neogit kind=floating<cr>", { desc = "Open Neogit" })
	end,
}
