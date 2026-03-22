require("neogit").setup({})

local map = require("utils").map

map("<leader>gN", "<cmd>Neogit kind=floating<cr>", "Open Neogit")
map("<leader>gdo", "<cmd>DiffviewOpen<cr>", "[G]it [D]iffview [O]pen against index")
map("<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", "[G]it [D]iffview [F]ile (current)")
map("<leader>gdF", "<cmd>DiffviewFileHistory<cr>", "[G]it [D]iffview [F]ile (All)")
map("<leader>gdo", function()
	local line_start = vim.fn.line("'<")
	local line_end = vim.fn.line("'>")
	vim.cmd(line_start .. "," .. line_end .. "DiffviewFileHistory")
end, "[G]it [D]iffview [F]ile (selection)", "v", { silent = true })
map("<leader>gdc", "<cmd>DiffviewClose<cr>", "[G]it [D]iffview [C]lose")
