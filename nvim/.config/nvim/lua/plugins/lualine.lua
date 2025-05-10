return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"catppuccin/nvim", -- Optional, for catppuccin theme integration
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto", -- or any other valid theme
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode", "record", "branch", "diagnostics" },
				lualine_b = { "filename", "readonly", "modified" },
				lualine_c = { "diff" },
				lualine_x = {
					{
						"macro",
						fmt = function()
							local reg = vim.fn.reg_recording()
							if reg ~= "" then
								return "Recording @" .. reg
							end
							return nil
						end,
						color = { fg = "#ff9e64" },
						draw_empty = false,
					},
					-- "encoding",
					-- "fileformat",
					"filetype",
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			extensions = { "lazy", "fzf" },
		})
	end,
}
