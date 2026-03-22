local ss = require("smart-splits")
local map = require("utils").map

local function bind(keys, func, desc)
	map(keys, func, "Smart Splits: " .. desc)
end

bind("<C-h>", ss.move_cursor_left, "Move Left")
bind("<C-j>", ss.move_cursor_down, "Move Down")
bind("<C-k>", ss.move_cursor_up, "Move Up")
bind("<C-l>", ss.move_cursor_right, "Move Right")

bind("<A-h>", ss.resize_left, "Resize Left")
bind("<A-j>", ss.resize_down, "Resize Down")
bind("<A-k>", ss.resize_up, "Resize Up")
bind("<A-l>", ss.resize_right, "Resize Right")
