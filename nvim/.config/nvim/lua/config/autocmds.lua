-- Autocmds loaded from init.lua before plugin/ scripts.
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kimchi-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
