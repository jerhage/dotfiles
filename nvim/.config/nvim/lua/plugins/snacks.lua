return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- bigfile adds a new filetype bigfile to Neovim that triggers when the file is larger than the configured size.
		-- This automatically prevents things like LSP and Treesitter attaching to the buffer.
		bigfile = { enabled = true },
		dashboard = { enabled = true },
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
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "[S]earch [F]iles [S]mart ",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[S]earch [B]uffers",
		},
		{
			"<leader>sF",
			function()
				Snacks.picker.grep()
			end,
			desc = "[S]earch files using [G]rep",
		},
		{
			"<leader>sn",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "[S]earch [N]eovim",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "[S]earch Files",
		},
		{
			"<leader>sG",
			function()
				Snacks.picker.git_files()
			end,
			desc = "[S]earch Git Files",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.projects()
			end,
			desc = "[S]earch Projects",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.recent()
			end,
			desc = "[S]earch Recent",
		},
		-- git
		{
			"<leader>sgb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "[S]earch Git [B]ranches",
		},
		{
			"<leader>sgl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "[S]earch Git [L]og",
		},
		{
			"<leader>sgL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "[S]earch Git Log [L]ine",
		},
		{
			"<leader>sgs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "[S]earch Git [S]tatus",
		},
		{
			"<leader>sgS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "[S]earch Git [S]tash",
		},
		{
			"<leader>sgd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "[S]earch Git [D]iff (Hunks)",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "[S]earch (Grep) Open Buffers",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "[S]earch current [W]ord",
			mode = { "n", "x" },
		},
		-- search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = '[S]earch ["] Registers',
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "[S]earch History",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "[S]earch [A]utocmds",
		},
		{
			"<leader>sL",
			function()
				Snacks.picker.lines()
			end,
			desc = "[S]earch [L]ines",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "[S]earch Command [:] History",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.commands()
			end,
			desc = "[S]earch [C]ommands",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]earch Workspace [Diagnostics]",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "[S]earch [Diagnostics]",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[S]earc [H]elp Pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "[S]earc [H]ighlights",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "[S]earch [I]cons",
		},
		-- {
		-- 	"<leader>sj",
		-- 	function()
		-- 		Snacks.picker.jumps()
		-- 	end,
		-- 	desc = "Jumps",
		-- },
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[S]earch [K]eymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "[S]earch [L]ocation List",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "[S]earch [M]arks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "[S]earch [M]an Pages",
		},
		-- {
		-- 	"<leader>sp",
		-- 	function()
		-- 		Snacks.picker.lazy()
		-- 	end,
		-- 	desc = "Search for Plugin Spec",
		-- },
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "[S]earch [Q]uickfix List",
		},
		-- {
		-- 	"<leader>sR",
		-- 	function()
		-- 		Snacks.picker.resume()
		-- 	end,
		-- 	desc = "Resume",
		-- },
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "[S]earch [U]ndo History",
		},
		{
			"<leader>sP",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "[S]earch Colorschemes",
		},
		-- LSP
		{
			"<leader>ld",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "[L]SP [D]efinition",
		},
		{
			"<space>lD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "[L]SP [D]eclaration",
		},
		{
			"<space>lr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "[L]SP [R]eferences",
		},
		{
			"<space>li",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "[L]SP [I]mplementation",
		},
		{
			"<space>lt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "[L]sp [T]ype Definition",
		},
		{
			"<space>ls",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "[L]SP [S]ymbols",
		},
		{
			"<space>lS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "[L]SP Workspace [S]ymbols",
		},
		-- Other
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle [Z]oom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		-- {
		-- 	"<leader>cR",
		-- 	function()
		-- 		Snacks.rename.rename_file()
		-- 	end,
		-- 	desc = "Rename File",
		-- },
		-- {
		-- 	"<leader>gB",
		-- 	function()
		-- 		Snacks.gitbrowse()
		-- 	end,
		-- 	desc = "Git Browse",
		-- 	mode = { "n", "v" },
		-- },
		-- {
		-- 	"<leader>gg",
		-- 	function()
		-- 		Snacks.lazygit()
		-- 	end,
		-- 	desc = "Lazygit",
		-- },
		-- {
		-- 	"<leader>un",
		-- 	function()
		-- 		Snacks.notifier.hide()
		-- 	end,
		-- 	desc = "Dismiss All Notifications",
		-- },
		-- {
		-- 	"<c-/>",
		-- 	function()
		-- 		Snacks.terminal()
		-- 	end,
		-- 	desc = "Toggle Terminal",
		-- },
		-- {
		-- 	"<c-_>",
		-- 	function()
		-- 		Snacks.terminal()
		-- 	end,
		-- 	desc = "which_key_ignore",
		-- },
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>N",
			desc = "Neovim News",
			function()
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
			end,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				-- _G.dd = function(...)
				-- 	Snacks.debug.inspect(...)
				-- end
				-- _G.bt = function()
				-- 	Snacks.debug.backtrace()
				-- end
				-- vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
				-- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				-- Snacks.toggle.diagnostics():map("<leader>ud")
				-- Snacks.toggle.line_number():map("<leader>ul")
				-- Snacks.toggle
				-- 	.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
				-- 	:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>tT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>tb")
				-- Snacks.toggle.inlay_hints():map("<leader>uh")
				-- Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>tD")
			end,
		})
	end,
}
