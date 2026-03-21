local ss = require("smart-splits")

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = "Smart Splits: " .. desc })
end

map("<C-h>", ss.move_cursor_left, "Move Left")
map("<C-j>", ss.move_cursor_down, "Move Down")
map("<C-k>", ss.move_cursor_up, "Move Up")
map("<C-l>", ss.move_cursor_right, "Move Right")

map("<A-h>", ss.resize_left, "Resize Left")
map("<A-j>", ss.resize_down, "Resize Down")
map("<A-k>", ss.resize_up, "Resize Up")
map("<A-l>", ss.resize_right, "Resize Right")
