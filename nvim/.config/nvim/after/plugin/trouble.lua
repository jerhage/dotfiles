require("trouble").setup({})

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "[Trouble] Toggle"})
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "[Trouble] Workspace"})
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "[Trouble] Document"})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "[Trouble] QuickFix"})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "[Trouble] LocList"})
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references", { desc = "[Trouble] LSP References"})
