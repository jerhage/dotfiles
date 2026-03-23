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

---@class DebugContext
---@field win integer|nil
---@field buf integer|nil

---@return DebugContext
M.save_context = function()
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_get_current_buf()

	return {
		win = vim.api.nvim_win_is_valid(win) and win or nil,
		buf = vim.api.nvim_buf_is_valid(buf) and buf or nil,
	}
end

---@param ctx DebugContext|nil
---@param pre_restore? fun():nil  -- optional callback executed before restore
---@return nil
M.restore_context = function(ctx, pre_restore)
	if not ctx then
		return
	end

	-- run caller-provided teardown (e.g. dapui.close)
	if pre_restore then
		pre_restore()
	end

	vim.schedule(function()
		if ctx.win and vim.api.nvim_win_is_valid(ctx.win) then
			vim.api.nvim_set_current_win(ctx.win)
		end

		if ctx.buf and vim.api.nvim_buf_is_valid(ctx.buf) then
			local current_win = vim.api.nvim_get_current_win()
			if vim.api.nvim_win_is_valid(current_win) then
				vim.api.nvim_win_set_buf(current_win, ctx.buf)
			end
		end
	end)
end

---@param ctx DebugContext|nil
---@param restoring boolean
---@param pre_restore? fun():nil  -- optional callback executed before restore
-- Restore exactly once per debug session, even if multiple teardown events fire.
M.safe_restore = function(ctx, restoring, pre_restore)
	if restoring then
		return
	end
	restoring = true

	M.restore_context(ctx, pre_restore)

	-- clear after scheduled restore
	vim.schedule(function()
		ctx = nil
		restoring = false
	end)
end

return M
