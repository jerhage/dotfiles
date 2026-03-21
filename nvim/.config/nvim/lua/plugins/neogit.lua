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
		vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "[G]it [D]iffview [O]pen against index" })
		vim.keymap.set(
			"n",
			"<leader>gdf",
			"<cmd>DiffviewFileHistory %<cr>",
			{ desc = "[G]it [D]iffview [F]ile (current)" }
		)
		vim.keymap.set("n", "<leader>gdF", "<cmd>DiffviewFileHistory<cr>", { desc = "[G]it [D]iffview [F]ile (All)" })
		vim.keymap.set("v", "<leader>gdo", function()
			local line_start = vim.fn.line("'<")
			local line_end = vim.fn.line("'>")
			vim.cmd(line_start .. "," .. line_end .. "DiffviewFileHistory")
		end, { desc = "[G]it [D]iffview [F]ile (selection)", silent = true })
		vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "[G]it [D]iffview [C]lose" })
	end,
}
