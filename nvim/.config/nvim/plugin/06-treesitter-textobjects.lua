local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")
local map = require("utils").map

-- nvim-treesitter-textobjects no longer uses nvim-treesitter.configs; use setup + keymaps.

require("nvim-treesitter-textobjects").setup({
	move = {
		set_jumps = true,
	},
})

map("<leader>a", function()
	swap.swap_next("@parameter.inner", "textobjects")
end, "Swap with next parameter")
map("<leader>A", function()
	swap.swap_previous("@parameter.inner", "textobjects")
end, "Swap with previous parameter")

map("]]", function()
	move.goto_next_start("@function.outer", "textobjects")
end, "Next function start", { "n", "x", "o" })
map("]m", function()
	move.goto_next_start("@class.outer", "textobjects")
end, "Next class start", { "n", "x", "o" })
map("]r", function()
	move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, "Next loop", { "n", "x", "o" })
map("]s", function()
	move.goto_next_start("@local.scope", "locals")
end, "Next scope", { "n", "x", "o" })
map("]z", function()
	move.goto_next_start("@fold", "folds")
end, "Next fold", { "n", "x", "o" })

map("[[", function()
	move.goto_previous_start("@function.outer", "textobjects")
end, "Previous function start", { "n", "x", "o" })
map("[m", function()
	move.goto_previous_start("@class.outer", "textobjects")
end, "Previous class start", { "n", "x", "o" })
map("[s", function()
	move.goto_previous_start("@local.scope", "locals")
end, "Previous scope", { "n", "x", "o" })

map("]}", function()
	move.goto_next_end("@function.outer", "textobjects")
end, nil, { "n", "x", "o" })
map("]M", function()
	move.goto_next_end("@class.outer", "textobjects")
end, nil, { "n", "x", "o" })
map("[{", function()
	move.goto_previous_end("@function.outer", "textobjects")
end, nil, { "n", "x", "o" })
map("[M", function()
	move.goto_previous_end("@class.outer", "textobjects")
end, nil, { "n", "x", "o" })

map("]e", function()
	move.goto_next("@conditional.outer", "textobjects")
end, nil, { "n", "x", "o" })
map("[e", function()
	move.goto_previous("@conditional.outer", "textobjects")
end, nil, { "n", "x", "o" })

-- Peek helpers from the old lsp_interop config are not in the current textobjects API; use LSP peek if needed.
