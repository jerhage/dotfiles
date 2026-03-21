require("lualine").setup({
	options = {
		theme = "auto",
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
	extensions = { "fzf" },
})
