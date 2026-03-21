if vim.fn.has("nvim-0.10.0") == 1 then
	require("ts-comments").setup({})
end

require("todo-comments").setup({
	signs = true,
	sign_priority = 8,
	keywords = {
		FIX = {
			icon = " ",
			color = "error",
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = "󰓅", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "󰙨", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},
	gui_style = {
		fg = "NONE",
		bg = "BOLD",
	},
	merge_keywords = true,
	highlight = {
		multiline = true,
		multiline_pattern = "^.",
		multiline_context = 10,
		before = "",
		keyword = "wide",
		after = "fg",
		pattern = [[.*<(KEYWORDS)\s*:]],
		comments_only = true,
		max_line_len = 400,
		exclude = {},
	},
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		test = { "Identifier", "#FF00FF" },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		pattern = [[\b(KEYWORDS):]],
	},
})

vim.keymap.set("n", "<leader>sT", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [T]odos" })
vim.keymap.set("n", "<leader>Tt", "<cmd>Trouble todo<cr>", { desc = "[T]rouble [T]odo" })
vim.keymap.set("n", "<leader>Tq", "<cmd>TodoQuickFix<cr>", { desc = "[T]odo [Q]uick Fix" })
vim.keymap.set("n", "<leader>Tl", "<cmd>TodoLocList<cr>", { desc = "[T]odo [L]ocation List" })
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Jump to next [t]odo" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Jump to previous [t]odo" })
