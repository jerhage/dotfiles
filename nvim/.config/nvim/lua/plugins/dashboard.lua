return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local db = require("dashboard")
		local sword_art = {
			"",
			"",
			"",
			"",
			"",
			"   Welcome, Master Swordsman!",
			"",
			"",
			"",
			",_,_,_,_,_,_,_,_,_,_|______________________________________________________",
			"|#|#|#|#|#|#|#|#|#|#|_____________________________________________________/",
			"'-'-'-'-'-'-'-'-'-'-|----------------------------------------------------'",
			"",
			"",
			".______________________________________________________|_._._._._._._._._._.",
			"\\_____________________________________________________|_#_#_#_#_#_#_#_#_#_|",
			"                                   l",
			"",
			"",
		}

		db.setup({
			theme = "doom", -- you can also use "hyper"
			config = {
				header = sword_art,

				center = {
					{ icon = "󰈔  ", desc = "New File", action = "enew", key = "n" },
					{
						icon = "󰱼  ",
						desc = "Find File",
						action = ":lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })",
						key = "f",
					},
					{ icon = "  ", desc = "Recent Files", action = "Telescope oldfiles", key = "r" },
					-- {
					-- 	icon = "  ",
					-- 	desc = "Restore Session",
					-- 	action = "lua require('persistence').load()",
					-- 	key = "s",
					-- },
					{ icon = "󰒲  ", desc = "Open Lazy", action = "Lazy", key = "l" },
					{ icon = "  ", desc = "Quit", action = "qa", key = "q" },
				},

				footer = { "Wield your editor wisely!" },
			},
		})
	end,
}
-- return {
-- 	"goolord/alpha-nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	event = "VimEnter",
-- 	config = function()
-- 		local alpha = require("alpha")
-- 		local dashboard = require("alpha.themes.dashboard")
--
-- 		-- Set header (ASCII art or logo)
-- 		dashboard.section.header.val = {
-- 			[[ ⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣶⣶⣦⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀ ]],
-- 			[[ ⠀⠀⠀⠀⠀⠀⣴⣿⡿⠛⠋⠉⠉⠉⠛⠻⢿⣷⣄⠀⠀⠀⠀⠀⠀ ]],
-- 			[[ ⠀⠀⠀⠀⣠⣾⡿⠁⠀⠀🧠 Welcome to Neovim⠀⠀⠈⢿⣷⡄⠀⠀⠀⠀ ]],
-- 			[[ ⠀⠀⣠⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣷⣄⠀⠀⠀⠀ ]],
-- 			[[ ⠀⣾⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⠀⠀⠀⠀ ]],
-- 		}
-- 		-- Set menu
-- 		dashboard.section.buttons.val = {
-- 			dashboard.button("e", "  New file", ":enew<CR>"),
-- 			dashboard.button("f", "󰱼  Find file", ":Telescope find_files<CR>"),
-- 			dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
-- 			-- dashboard.button("s", "  Restore session", ":lua require('persistence').load()<CR>"),
-- 			dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
-- 			dashboard.button("q", "  Quit", ":qa<CR>"),
-- 		}
--
-- 		-- Optional footer
-- 		dashboard.section.footer.val = "✨ Happy Hacking with Neovim ✨"
--
-- 		dashboard.opts.opts.noautocmd = true
-- 		alpha.setup(dashboard.opts)
-- 	end,
-- }
