require("yazi").setup({
	open_for_directories = true,
	use_ya_for_events_reading = true,
	use_yazi_client_id_flag = true,
	keymaps = {
		show_help = "?",
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })
