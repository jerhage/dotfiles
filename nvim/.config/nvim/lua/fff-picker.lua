-- INFO: [WIP] Trying to integrate fff with the snack picker but having problems
local M = {}

local staged_status = {
	staged_new = true,
	staged_modified = true,
	staged_deleted = true,
	renamed = true,
}

local status_map = {
	untracked = "untracked",
	modified = "modified",
	deleted = "deleted",
	renamed = "renamed",
	staged_new = "added",
	staged_modified = "modified",
	staged_deleted = "deleted",
	ignored = "ignored",
	unknown = "untracked",
}

M.state = {}

local function finder(opts, ctx)
	local file_picker = require("fff.file_picker")

	-- cache current file so fff can boost its frecency score
	if not M.state.current_file_cache then
		local buf = vim.api.nvim_get_current_buf()
		if buf and vim.api.nvim_buf_is_valid(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			if name ~= "" and vim.fn.filereadable(name) == 1 then
				M.state.current_file_cache = name
			end
		end
	end

	-- args: query, max_results, threads, current_file, include_ignored
	-- local results = file_picker.search_files(ctx.filter.search, 100, 4, M.state.current_file_cache, false)
	local results = file_picker.search_files(ctx.filter.search, 100, 4, M.state.current_file_cache, 0)

	local items = {}
	for _, fff_item in ipairs(results) do
		items[#items + 1] = {
			text = fff_item.name,
			file = fff_item.path,
			score = fff_item.total_frecency_score,
			status = status_map[fff_item.git_status] and {
				status = status_map[fff_item.git_status],
				staged = staged_status[fff_item.git_status] or false,
				unmerged = fff_item.git_status == "unmerged",
			},
		}
	end

	return items
end

local function on_close()
	M.state.current_file_cache = nil
end

local function format_git_status(item, picker)
	local ret = {}
	local s = item.status
	local hl

	if s.unmerged then
		hl = "SnacksPickerGitStatusUnmerged"
	elseif s.staged then
		hl = "SnacksPickerGitStatusStaged"
	else
		hl = "SnacksPickerGitStatus" .. s.status:sub(1, 1):upper() .. s.status:sub(2)
	end

	local icon = picker.opts.icons.git[s.status]
	if s.staged then
		icon = picker.opts.icons.git.staged
	end

	local text_icon = s.status:sub(1, 1):upper()
	if s.status == "untracked" then
		text_icon = "?"
	elseif s.status == "ignored" then
		text_icon = "!"
	end

	ret[#ret + 1] = { icon, hl }
	ret[#ret + 1] = { " ", virtual = true }
	ret[#ret + 1] = {
		col = 0,
		virt_text = { { text_icon, hl }, { " " } },
		virt_text_pos = "right_align",
		hl_mode = "combine",
	}
	return ret
end

local function format(item, picker)
	local ret = {}

	if item.label then
		ret[#ret + 1] = { item.label, "SnacksPickerLabel" }
		ret[#ret + 1] = { " ", virtual = true }
	end

	if item.status then
		vim.list_extend(ret, format_git_status(item, picker))
	else
		ret[#ret + 1] = { " ", virtual = true }
	end

	vim.list_extend(ret, require("snacks.picker.format").filename(item, picker))

	if item.line then
		Snacks.picker.highlight.format(item, item.line, ret)
		ret[#ret + 1] = { " " }
	end

	return ret
end

function M.fff()
	local file_picker = require("fff.file_picker")
	if not file_picker.is_initialized() then
		if not file_picker.setup() then
			vim.notify("fff: failed to initialize", vim.log.levels.ERROR)
			return
		end
	end

	Snacks.picker({
		title = "Files",
		finder = finder,
		format = format,
		on_close = on_close,
		live = true, -- re-runs finder on every keystroke
	})
end

local function grep_finder(opts, ctx)
	local grep = require("fff.grep")

	local query = ctx.filter.search
	if not query or query == "" then
		return {}
	end

	local results = grep.search(query, {
		cwd = require("utils").get_root(),
		max_results = 200,
		modes = opts.modes or { "fuzzy", "plain" },
	})

	local items = {}
	for _, result in ipairs(results) do
		items[#items + 1] = {
			text = result.line,
			file = result.path,
			pos = { result.line_number, result.col },
			-- display the matched line as the label
			label = string.format("%s:%d", result.path, result.line_number),
		}
	end

	return items
end

function M.live_grep(opts)
	opts = opts or {}
	Snacks.picker({
		title = "Live Grep (fff)",
		finder = function(finder_opts, ctx)
			return grep_finder(finder_opts, ctx)
		end,
		format = function(item, picker)
			local ret = {}
			-- show filename
			vim.list_extend(ret, require("snacks.picker.format").filename(item, picker))
			-- show matched line content
			if item.text then
				ret[#ret + 1] = { " ", virtual = true }
				ret[#ret + 1] = { item.text, "SnacksPickerMatch" }
			end
			return ret
		end,
		live = true,
		jump = { reuse_win = true },
		-- pass through grep mode opts
		modes = opts.modes,
	})
end

return M
