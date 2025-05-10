local set = vim.keymap.set
set("i", "jj", "<Esc>")
vim.g.mapleader = " "

set("n", "<CR>", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.opt.hlsearch:get() then
		vim.cmd.nohl()
		return ""
	else
		return "<CR>"
	end
end, { expr = true })
--
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  See `:help wincmd` for a list of all window commands
--  Using smartsplits for this: see 'lua/plugins/smart-splits.lua'
-- set("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
-- set("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
-- set("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
-- set("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })
