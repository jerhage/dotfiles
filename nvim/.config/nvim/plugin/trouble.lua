require("trouble").setup({})

local map = require("utils").map

map("<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)")
map("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)")
map("<leader>xs", "<cmd>Trouble symbols toggle focus=false win.size=0.3<cr>", "Symbols (Trouble)")
map(
	"<leader>xl",
	"<cmd>Trouble lsp toggle focus=false win.position=right win.size=0.3<cr>",
	"LSP Definitions / references / ... (Trouble)"
)
map("<leader>xL", "<cmd>Trouble loclist toggle<cr>", "Location List (Trouble)")
map("<leader>xQ", "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)")
