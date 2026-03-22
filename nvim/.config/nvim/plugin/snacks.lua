---@type snacks.Config
require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
	},
	explorer = { enabled = false },
	indent = { enabled = true },
	input = { enabled = false },
	notifier = {
		enabled = false,
		timeout = 3000,
	},
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = false },
	words = { enabled = true },
	styles = {
		notification = {},
	},
})

vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "[S]earch [F]iles [S]mart " })
vim.keymap.set("n", "<leader>sb", function()
	Snacks.picker.buffers()
end, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sF", function()
	Snacks.picker.grep()
end, { desc = "[S]earch files using [G]rep" })
vim.keymap.set("n", "<leader>sn", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim" })
vim.keymap.set("n", "<leader>sf", function()
	Snacks.picker.files()
end, { desc = "[S]earch Files" })
vim.keymap.set("n", "<leader>sG", function()
	Snacks.picker.git_files()
end, { desc = "[S]earch Git Files" })
vim.keymap.set("n", "<leader>sp", function()
	Snacks.picker.projects()
end, { desc = "[S]earch Projects" })
vim.keymap.set("n", "<leader>sr", function()
	Snacks.picker.recent()
end, { desc = "[S]earch Recent" })
vim.keymap.set("n", "<leader>sgb", function()
	Snacks.picker.git_branches()
end, { desc = "[S]earch Git [B]ranches" })
vim.keymap.set("n", "<leader>sgl", function()
	Snacks.picker.git_log()
end, { desc = "[S]earch Git [L]og" })
vim.keymap.set("n", "<leader>sgL", function()
	Snacks.picker.git_log_line()
end, { desc = "[S]earch Git Log [L]ine" })
vim.keymap.set("n", "<leader>sgs", function()
	Snacks.picker.git_status()
end, { desc = "[S]earch Git [S]tatus" })
vim.keymap.set("n", "<leader>sgS", function()
	Snacks.picker.git_stash()
end, { desc = "[S]earch Git [S]tash" })
vim.keymap.set("n", "<leader>sgd", function()
	Snacks.picker.git_diff()
end, { desc = "[S]earch Git [D]iff (Hunks)" })
vim.keymap.set("n", "<leader>sB", function()
	Snacks.picker.grep_buffers()
end, { desc = "[S]earch (Grep) Open Buffers" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", '<leader>s"', function()
	Snacks.picker.registers()
end, { desc = '[S]earch ["] Registers' })
vim.keymap.set("n", "<leader>s/", function()
	Snacks.picker.search_history()
end, { desc = "[S]earch History" })
vim.keymap.set("n", "<leader>sa", function()
	Snacks.picker.autocmds()
end, { desc = "[S]earch [A]utocmds" })
vim.keymap.set("n", "<leader>sL", function()
	Snacks.picker.lines()
end, { desc = "[S]earch [L]ines" })
vim.keymap.set("n", "<leader>:", function()
	Snacks.picker.command_history()
end, { desc = "[S]earch Command [:] History" })
vim.keymap.set("n", "<leader>sc", function()
	Snacks.picker.commands()
end, { desc = "[S]earch [C]ommands" })
vim.keymap.set("n", "<leader>sD", function()
	Snacks.picker.diagnostics()
end, { desc = "[S]earch Workspace [Diagnostics]" })
vim.keymap.set("n", "<leader>sd", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "[S]earch [Diagnostics]" })
vim.keymap.set("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "[S]earc [H]elp Pages" })
vim.keymap.set("n", "<leader>sH", function()
	Snacks.picker.highlights()
end, { desc = "[S]earc [H]ighlights" })
vim.keymap.set("n", "<leader>si", function()
	Snacks.picker.icons()
end, { desc = "[S]earch [I]cons" })
vim.keymap.set("n", "<leader>sk", function()
	Snacks.picker.keymaps()
end, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sl", function()
	Snacks.picker.loclist()
end, { desc = "[S]earch [L]ocation List" })
vim.keymap.set("n", "<leader>sm", function()
	Snacks.picker.marks()
end, { desc = "[S]earch [M]arks" })
vim.keymap.set("n", "<leader>sM", function()
	Snacks.picker.man()
end, { desc = "[S]earch [M]an Pages" })
vim.keymap.set("n", "<leader>sq", function()
	Snacks.picker.qflist()
end, { desc = "[S]earch [Q]uickfix List" })
vim.keymap.set("n", "<leader>su", function()
	Snacks.picker.undo()
end, { desc = "[S]earch [U]ndo History" })
vim.keymap.set("n", "<leader>sP", function()
	Snacks.picker.colorschemes()
end, { desc = "[S]earch Colorschemes" })
vim.keymap.set("n", "<leader>ld", function()
	Snacks.picker.lsp_definitions()
end, { desc = "[L]SP [D]efinition" })
vim.keymap.set("n", "<space>lD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "[L]SP [D]eclaration" })
vim.keymap.set("n", "<space>lr", function()
	Snacks.picker.lsp_references()
end, { desc = "[L]SP [R]eferences", nowait = true })
vim.keymap.set("n", "<space>li", function()
	Snacks.picker.lsp_implementations()
end, { desc = "[L]SP [I]mplementation" })
vim.keymap.set("n", "<space>lt", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "[L]sp [T]ype Definition" })
vim.keymap.set("n", "<space>ls", function()
	Snacks.picker.lsp_symbols()
end, { desc = "[L]SP [S]ymbols" })
vim.keymap.set("n", "<space>lS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "[L]SP Workspace [S]ymbols" })
vim.keymap.set("n", "<leader>z", function()
	Snacks.zen()
end, { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>Z", function()
	Snacks.zen.zoom()
end, { desc = "Toggle [Z]oom" })
vim.keymap.set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })
vim.keymap.set("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })
vim.keymap.set("n", "<leader>N", function()
	Snacks.win({
		file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
		width = 0.6,
		height = 0.6,
		wo = {
			spell = false,
			wrap = false,
			signcolumn = "yes",
			statuscolumn = " ",
			conceallevel = 3,
		},
	})
end, { desc = "Neovim News" })

vim.schedule(function()
	-- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
	Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
	Snacks.toggle.treesitter():map("<leader>tT")
	-- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>tb")
	-- Snacks.toggle.dim():map("<leader>tD")
end)
