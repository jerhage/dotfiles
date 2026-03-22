local harpoon = require("harpoon")
local map = require("utils").map

harpoon:setup()

map("<leader>hm", function()
	harpoon:list():add()
end, "[H]arpoon: [M]ark")
map("<leader>hl", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, "[H]arpoon: [L]ist")

for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
	map(string.format("<space>h%d", idx), function()
		harpoon:list():select(idx)
	end, string.format("[H]arpoon: navigate to %d", idx))
end
