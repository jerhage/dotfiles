local M = {}

---@param keys string|table
---@param func string|function
---@param desc? string
---@param mode? string|table
---@param opts? table
M.map = function(keys, func, desc, mode, opts)
	opts = vim.tbl_extend("force", {}, opts or {})
	if desc ~= nil then
		opts.desc = desc
	end
	vim.keymap.set(mode or "n", keys, func, opts)
end

return M
