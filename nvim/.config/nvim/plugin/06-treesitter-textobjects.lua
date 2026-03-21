local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

-- nvim-treesitter-textobjects no longer uses nvim-treesitter.configs; use setup + keymaps.

require("nvim-treesitter-textobjects").setup({
	move = {
		set_jumps = true,
	},
})

vim.keymap.set("n", "<leader>a", function()
	swap.swap_next("@parameter.inner", "textobjects")
end, { desc = "Swap with next parameter" })
vim.keymap.set("n", "<leader>A", function()
	swap.swap_previous("@parameter.inner", "textobjects")
end, { desc = "Swap with previous parameter" })

vim.keymap.set({ "n", "x", "o" }, "]]", function()
	move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })
vim.keymap.set({ "n", "x", "o" }, "]m", function()
	move.goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class start" })
vim.keymap.set({ "n", "x", "o" }, "]r", function()
	move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "Next loop" })
vim.keymap.set({ "n", "x", "o" }, "]s", function()
	move.goto_next_start("@local.scope", "locals")
end, { desc = "Next scope" })
vim.keymap.set({ "n", "x", "o" }, "]z", function()
	move.goto_next_start("@fold", "folds")
end, { desc = "Next fold" })

vim.keymap.set({ "n", "x", "o" }, "[[", function()
	move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })
vim.keymap.set({ "n", "x", "o" }, "[m", function()
	move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "Previous class start" })
vim.keymap.set({ "n", "x", "o" }, "[s", function()
	move.goto_previous_start("@local.scope", "locals")
end, { desc = "Previous scope" })

vim.keymap.set({ "n", "x", "o" }, "]}", function()
	move.goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]M", function()
	move.goto_next_end("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[{", function()
	move.goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[M", function()
	move.goto_previous_end("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]e", function()
	move.goto_next("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[e", function()
	move.goto_previous("@conditional.outer", "textobjects")
end)

-- Peek helpers from the old lsp_interop config are not in the current textobjects API; use LSP peek if needed.
