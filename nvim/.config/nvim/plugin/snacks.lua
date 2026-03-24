---@type snacks.Config
require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
		preset = {
			-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
			---@type fun(cmd:string, opts:table)|nil
			pick = nil,
			-- Used by the `keys` section to show keymaps.
			-- Set your custom keymaps here.
			-- When using a function, the `items` argument are the default keymaps.
			---@type snacks.dashboard.Item[]
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "F", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
				{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			-- Used by the `header` section
			header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
		},
	},
	dim = { enabled = true },
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

local map = require("utils").map

map("<leader><space>", function()
	Snacks.picker.smart()
end, "[S]earch [F]iles [S]mart ")
map("<leader>sb", function()
	Snacks.picker.buffers()
end, "[S]earch [B]uffers")
-- map("<leader>sF", function()
-- 	Snacks.picker.grep()
-- end, "[S]earch files using [G]rep")
map("<leader>sn", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, "[S]earch [N]eovim")
-- map("<leader>sf", function()
-- 	Snacks.picker.files()
-- end, "[S]earch Files")
map("<leader>sG", function()
	Snacks.picker.git_files()
end, "[S]earch Git Files")
map("<leader>sp", function()
	Snacks.picker.projects()
end, "[S]earch Projects")
map("<leader>sr", function()
	Snacks.picker.recent()
end, "[S]earch Recent")
map("<leader>sgb", function()
	Snacks.picker.git_branches()
end, "[S]earch Git [B]ranches")
map("<leader>sgl", function()
	Snacks.picker.git_log()
end, "[S]earch Git [L]og")
map("<leader>sgL", function()
	Snacks.picker.git_log_line()
end, "[S]earch Git Log [L]ine")
map("<leader>sgs", function()
	Snacks.picker.git_status()
end, "[S]earch Git [S]tatus")
map("<leader>sgS", function()
	Snacks.picker.git_stash()
end, "[S]earch Git [S]tash")
map("<leader>sgd", function()
	Snacks.picker.git_diff()
end, "[S]earch Git [D]iff (Hunks)")
map("<leader>sB", function()
	Snacks.picker.grep_buffers()
end, "[S]earch (Grep) Open Buffers")
-- map("<leader>sw", function()
-- 	Snacks.picker.grep_word()
-- end, "[S]earch current [W]ord", { "n", "x" })
map('<leader>s"', function()
	Snacks.picker.registers()
end, '[S]earch ["] Registers')
map("<leader>s/", function()
	Snacks.picker.search_history()
end, "[S]earch History")
map("<leader>sa", function()
	Snacks.picker.autocmds()
end, "[S]earch [A]utocmds")
map("<leader>sL", function()
	Snacks.picker.lines()
end, "[S]earch [L]ines")
map("<leader>:", function()
	Snacks.picker.command_history()
end, "[S]earch Command [:] History")
map("<leader>sc", function()
	Snacks.picker.commands()
end, "[S]earch [C]ommands")
map("<leader>sD", function()
	Snacks.picker.diagnostics()
end, "[S]earch Workspace [Diagnostics]")
map("<leader>sd", function()
	Snacks.picker.diagnostics_buffer()
end, "[S]earch [Diagnostics]")
map("<leader>sh", function()
	Snacks.picker.help()
end, "[S]earc [H]elp Pages")
map("<leader>sH", function()
	Snacks.picker.highlights()
end, "[S]earc [H]ighlights")
map("<leader>si", function()
	Snacks.picker.icons()
end, "[S]earch [I]cons")
map("<leader>sk", function()
	Snacks.picker.keymaps()
end, "[S]earch [K]eymaps")
map("<leader>sl", function()
	Snacks.picker.loclist()
end, "[S]earch [L]ocation List")
map("<leader>sm", function()
	Snacks.picker.marks()
end, "[S]earch [M]arks")
map("<leader>sM", function()
	Snacks.picker.man()
end, "[S]earch [M]an Pages")
map("<leader>sq", function()
	Snacks.picker.qflist()
end, "[S]earch [Q]uickfix List")
map("<leader>su", function()
	Snacks.picker.undo()
end, "[S]earch [U]ndo History")
map("<leader>sP", function()
	Snacks.picker.colorschemes()
end, "[S]earch Colorschemes")
map("<leader>ld", function()
	Snacks.picker.lsp_definitions()
end, "[L]SP [D]efinition")
map("<space>lD", function()
	Snacks.picker.lsp_declarations()
end, "[L]SP [D]eclaration")
map("<space>lr", function()
	Snacks.picker.lsp_references()
end, "[L]SP [R]eferences", nil, { nowait = true })
map("<space>li", function()
	Snacks.picker.lsp_implementations()
end, "[L]SP [I]mplementation")
map("<space>lt", function()
	Snacks.picker.lsp_type_definitions()
end, "[L]sp [T]ype Definition")
map("<space>ls", function()
	Snacks.picker.lsp_symbols()
end, "[L]SP [S]ymbols")
map("<space>lS", function()
	Snacks.picker.lsp_workspace_symbols()
end, "[L]SP Workspace [S]ymbols")
map("<leader>z", function()
	Snacks.zen()
end, "Toggle Zen Mode")
map("<leader>Z", function()
	Snacks.zen.zoom()
end, "Toggle [Z]oom")
map("<leader>.", function()
	Snacks.scratch()
end, "Toggle Scratch Buffer")
map("<leader>S", function()
	Snacks.scratch.select()
end, "Select Scratch Buffer")
map("<leader>bd", function()
	Snacks.bufdelete()
end, "Delete Buffer")
map("]]", function()
	Snacks.words.jump(vim.v.count1)
end, "Next Reference", { "n", "t" })
map("[[", function()
	Snacks.words.jump(-vim.v.count1)
end, "Prev Reference", { "n", "t" })
map("<leader>N", function()
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
end, "Neovim News")

vim.schedule(function()
	-- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
	Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
	Snacks.toggle.treesitter():map("<leader>tT")
	-- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>tb")
	Snacks.toggle.dim():map("<leader>tD")
end)
