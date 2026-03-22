local M = {}

M.map = function(keys, func, desc, mode)
	vim.keymap.set(mode or "n", keys, func, { desc = desc })
end

return M
