return {
	"echasnovski/mini.icons",
	event = "VeryLazy",
	opts = {
		file = {
			[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
			["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
		},
		filetype = {
			dotenv = { glyph = "", hl = "MiniIconsYellow" },
		},
	},
	init = function()
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
}
