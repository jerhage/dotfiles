require("neogit").setup({})

local map = require("utils").map

map("<leader>gN", "<cmd>Neogit kind=floating<cr>", "Open Neogit")
map("<leader>gdo", "<cmd>DiffviewOpen<cr>", "[G]it [D]iffview [O]pen against index")
map("<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", "[G]it [D]iffview [F]ile (current)")
map("<leader>gdF", "<cmd>DiffviewFileHistory<cr>", "[G]it [D]iffview [F]ile (All)")
map("<leader>gdb", function()
	vim.ui.input({
		prompt = "Base branch: ",
		default = "main",
	}, function(base)
		if not base or base == "" then
			return
		end

		vim.cmd("DiffviewFileHistory --range=" .. vim.fn.fnameescape(base .. "..HEAD"))
	end)
end, "[G]it [D]iffview [B]ranch History")
map("<leader>gdn", function()
	local count = tonumber(vim.fn.input("Commits back: ", "10"))

	if count and count > 0 and count % 1 == 0 then
		vim.cmd("DiffviewFileHistory --range=" .. vim.fn.fnameescape(("HEAD~%d..HEAD"):format(count)))
	end
end, "[G]it [D]iffview Last [N] Commits")
map("<leader>gdo", function()
	local line_start = vim.fn.line("'<")
	local line_end = vim.fn.line("'>")
	vim.cmd(line_start .. "," .. line_end .. "DiffviewFileHistory")
end, "[G]it [D]iffview [F]ile (selection)", "v", { silent = true })
map("<leader>gdc", "<cmd>DiffviewClose<cr>", "[G]it [D]iffview [C]lose")
