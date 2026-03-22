require("yazi").setup({
	open_for_directories = true,
	use_ya_for_events_reading = true,
	use_yazi_client_id_flag = true,
	keymaps = {
		show_help = "?",
	},
})

local map = require("utils").map

map("<leader>e", "<cmd>Yazi<cr>", "Open yazi at the current file")
map("<c-up>", "<cmd>Yazi toggle<cr>", "Resume the last yazi session")
