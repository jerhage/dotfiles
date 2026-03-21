local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>hm", function()
	harpoon:list():add()
end, { desc = "[H]arpoon: [M]ark" })
vim.keymap.set("n", "<leader>hl", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[H]arpoon: [L]ist" })

for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
	vim.keymap.set("n", string.format("<space>h%d", idx), function()
		harpoon:list():select(idx)
	end, { desc = string.format("[H]arpoon: navigate to %d", idx) })
end
