vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DiagnosticError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "◆",
	texthl = "DiagnosticWarn",
})

vim.fn.sign_define("DapLogPoint", {
	text = "◆",
	texthl = "DiagnosticInfo",
})

vim.fn.sign_define("DapStopped", {
	text = "▶",
	texthl = "DiagnosticInfo",
	linehl = "Visual",
	numhl = "",
})

local dap = require("dap")
local dapui = require("dapui")
local save_context = require("utils").save_context
local safe_restore = require("utils").safe_restore
local uv = vim.uv or vim.loop

local ctx = nil
local isRestoring = false

-- Setup dap hooks. In particular, save and restore context so I land in the buffer from which I launched the debugger
dap.listeners.before.launch.dapui_config = function()
	ctx = save_context()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	safe_restore(ctx, isRestoring, dapui.close)
end
dap.listeners.before.event_exited.dapui_config = function()
	safe_restore(ctx, isRestoring, dapui.close)
end
dap.listeners.before.attach.dapui_config = function()
	save_context()
	dapui.open()
end

-- INFO: consider only restoring on event_exited if safe_restore doesn't play well with current adapter
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
	controls = {
		-- icons = {
		-- 	pause = "⏸",
		-- 	play = "▶",
		-- 	step_into = "⏎",
		-- 	step_over = "⏭",
		-- 	step_out = "⏮",
		-- 	step_back = "b",
		-- 	run_last = "▶▶",
		-- 	terminate = "⏹",
		-- 	disconnect = "⏏",
		-- },
	},
})

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = { mason_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
	},
}

local js_filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
local vitest_config_names = {
	"vitest.config.ts",
	"vitest.config.js",
	"vite.config.ts",
	"vite.config.js",
	"vitest.config.mts",
	"vitest.config.mjs",
	"vite.config.mts",
	"vite.config.mjs",
}

local function path_exists(path)
	return path and uv.fs_stat(path) ~= nil
end

local function search_upward(path, targets)
	local start = path
	local stat = path and uv.fs_stat(path)
	if stat and stat.type == "file" then
		start = vim.fs.dirname(path)
	end
	local found = vim.fs.find(targets, {
		path = start,
		upward = true,
		type = "file",
	})[1]
	return found and vim.fs.dirname(found) or nil
end

local function find_vitest_config(path)
	local root = search_upward(path, vitest_config_names)
	if not root then
		return nil
	end
	for _, name in ipairs(vitest_config_names) do
		local candidate = root .. "/" .. name
		if path_exists(candidate) then
			return candidate
		end
	end
	return nil
end

local function find_package_root(path)
	return search_upward(path, { "package.json" })
end

local function find_vitest_workspace_root(path)
	return search_upward(path, vitest_config_names) or find_package_root(path)
end

local function read_json_file(path)
	if not path_exists(path) then
		return nil
	end
	local ok, lines = pcall(vim.fn.readfile, path)
	if not ok then
		return nil
	end
	local decoded_ok, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
	if not decoded_ok then
		return nil
	end
	return decoded
end

local function find_vitest_project_root(path)
	local package_root = find_package_root(path)
	local workspace_root = find_vitest_workspace_root(path)
	if package_root and workspace_root and package_root ~= workspace_root then
		return package_root
	end
	return nil
end

local function find_vitest_project_name(path)
	local project_root = find_vitest_project_root(path)
	if not project_root then
		return nil
	end
	local package_json = read_json_file(project_root .. "/package.json")
	if type(package_json) == "table" and type(package_json.name) == "string" and package_json.name ~= "" then
		return package_json.name
	end
	return vim.fs.basename(project_root)
end

local function current_vitest_workspace_root()
	return find_vitest_workspace_root(vim.api.nvim_buf_get_name(0)) or vim.fn.getcwd()
end

local function relative_to_root(path, root)
	if not path or not root then
		return path
	end
	local normalized_path = vim.fs.normalize(path)
	local normalized_root = vim.fs.normalize(root)
	local prefix = normalized_root .. "/"
	if normalized_path == normalized_root then
		return "."
	end
	if vim.startswith(normalized_path, prefix) then
		return normalized_path:sub(#prefix + 1)
	end
	return path
end

local function count_tree_nodes(tree)
	if not tree then
		return 0
	end
	local count = 0
	for _ in tree:iter() do
		count = count + 1
	end
	return count
end

local function strip_wrapping_quotes(text)
	if type(text) ~= "string" or #text < 2 then
		return text
	end
	local first = text:sub(1, 1)
	local last = text:sub(-1)
	if (first == "'" or first == '"' or first == "`") and first == last then
		return text:sub(2, -2)
	end
	return text
end

local function first_named_child(node)
	if not node then
		return nil
	end
	for child in node:iter_children() do
		if child:named() then
			return child
		end
	end
	return nil
end

local function extract_call_name(call_node, source)
	local args = call_node:field("arguments")[1]
	local name_node = first_named_child(args)
	if not name_node then
		return nil
	end
	local name = vim.treesitter.get_node_text(name_node, source)
	if not name or name == "" then
		return nil
	end
	return strip_wrapping_quotes(name)
end

local function classify_vitest_call(call_node, source)
	local func = call_node:field("function")[1]
	if not func then
		return nil
	end
	local callee = vim.treesitter.get_node_text(func, source)
	if not callee or callee == "" then
		return nil
	end
	callee = callee:gsub("%s+", "")
	if callee == "describe" or vim.startswith(callee, "describe.") or vim.startswith(callee, "describe(") then
		return "namespace"
	end
	if callee == "test" or vim.startswith(callee, "test.") or vim.startswith(callee, "test(") then
		return "test"
	end
	if callee == "it" or vim.startswith(callee, "it.") or vim.startswith(callee, "it(") then
		return "test"
	end
	return nil
end

local function collect_vitest_positions(node, source, file_path, positions)
	if node:type() == "call_expression" then
		local kind = classify_vitest_call(node, source)
		local name = kind and extract_call_name(node, source)
		if kind and name and name ~= "" then
			local start_row, start_col, end_row, end_col = node:range()
			table.insert(positions, {
				type = kind,
				path = file_path,
				name = name,
				range = { start_row, start_col, end_row, end_col },
			})
		end
	end
	for child in node:iter_children() do
		if child:named() then
			collect_vitest_positions(child, source, file_path, positions)
		end
	end
end

-- cannot for the life of me get neotest to find vitest by itself so here we are
local function fallback_discover_positions(file_path)
	local lib = require("neotest.lib")
	local ok, lines = pcall(vim.fn.readfile, file_path)
	if not ok or not lines then
		return nil
	end
	local source = table.concat(lines, "\n")
	local lang = vim.filetype.match({ filename = file_path })
	if lang == "typescriptreact" then
		lang = "tsx"
	elseif lang == "javascriptreact" then
		lang = "jsx"
	end
	if lang ~= "tsx" and lang ~= "jsx" and lang ~= "typescript" and lang ~= "javascript" then
		return nil
	end
	local parser_ok, parser = pcall(vim.treesitter.get_string_parser, source, lang)
	if not parser_ok or not parser then
		return nil
	end
	local tree_ok, parsed = pcall(function()
		return parser:parse()
	end)
	if not tree_ok or not parsed or not parsed[1] then
		return nil
	end
	local root = parsed[1]:root()
	if not root then
		return nil
	end
	local _, _, end_row, end_col = root:range()
	local positions = {
		{
			type = "file",
			path = file_path,
			name = vim.fs.basename(file_path),
			range = { 0, 0, end_row, end_col },
		},
	}
	collect_vitest_positions(root, source, file_path, positions)
	return lib.positions.parse_tree(positions, { nested_tests = true })
end

local function is_vitest_test_file(file_path)
	if not file_path or file_path == "" then
		return false
	end
	if not find_vitest_workspace_root(file_path) then
		return false
	end
	if file_path:match("/__tests__/") then
		return true
	end
	return file_path:match("%.test%.[cm]?[jt]sx?$")
		or file_path:match("%.spec%.[cm]?[jt]sx?$")
		or file_path:match("%.e2e%.[cm]?[jt]sx?$")
end

-- Shared with Neotest Vitest DAP strategy (neotest-vitest only passes runtimeExecutable + args; without these, frames often map to wrong lines -> nvim-dap invalid cursor warnings).
local vitest_js_debug_shared = {
	autoAttachChildProcesses = true,
	smartStep = true,
	skipFiles = {
		"<node_internals>/**",
		"**/node_modules/**",
	},
	sourceMaps = true,
	outFiles = {
		"${workspaceFolder}/**/*.js",
		"${workspaceFolder}/**/*.mjs",
		"${workspaceFolder}/**/*.cjs",
	},
	resolveSourceMapLocations = {
		"${workspaceFolder}/**",
		"!**/node_modules/**",
		"!**/*.css",
		"!**/*.scss",
		"!**/*.sass",
		"!**/*.less",
		"!**/*.styl",
		"!**/*.json",
	},
	trace = true,
}

for _, ft in ipairs(js_filetypes) do
	dap.configurations[ft] = {
		vim.tbl_deep_extend("force", {
			type = "pwa-node",
			request = "launch",
			name = "Debug Vitest (current file)",

			program = function()
				local root = current_vitest_workspace_root()
				local vitest = root .. "/node_modules/vitest/vitest.mjs"
				return path_exists(vitest) and vitest or "${workspaceFolder}/node_modules/vitest/vitest.mjs"
			end,
			args = {
				"run",
				function()
					return relative_to_root(vim.api.nvim_buf_get_name(0), current_vitest_workspace_root())
				end,
				"--reporter=verbose",
				"--no-file-parallelism",
				"--test-timeout=0",
				"--hook-timeout=0",
				"--teardown-timeout=0",
			},

			cwd = current_vitest_workspace_root,
			rootDir = current_vitest_workspace_root,
			console = "integratedTerminal",
		}, vitest_js_debug_shared),
		vim.tbl_deep_extend("force", {
			type = "pwa-node",
			request = "attach",
			name = "Attach to Vitest",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		}, vitest_js_debug_shared),
	}
end

-- inline variable values while stepping
require("nvim-dap-virtual-text").setup({})

-- language dap adapters
require("dap-go").setup()
require("dap-python").setup("python") -- or path to venv python

-- neotest-vitest built-in DAP spec is minimal; merge js-debug source map options so stack frames resolve to real buffer lines.
local neotest_vitest_adapter = require("neotest-vitest")({
	cwd = function(path)
		return find_vitest_workspace_root(path)
	end,
	vitestConfigFile = function(path)
		return find_vitest_config(path)
	end,
	is_test_file = is_vitest_test_file,
	filter_dir = function(name, rel_path, root)
		return name ~= "node_modules"
	end,
})
neotest_vitest_adapter.is_test_file = is_vitest_test_file
neotest_vitest_adapter.root = function(path)
	return find_vitest_workspace_root(path)
end
do
	local orig_build_spec = neotest_vitest_adapter.build_spec
	local orig_discover_positions = neotest_vitest_adapter.discover_positions
	neotest_vitest_adapter.discover_positions = function(path)
		if not is_vitest_test_file(path) then
			return orig_discover_positions(path)
		end
		local positions = fallback_discover_positions(path)
		if count_tree_nodes(positions) > 1 then
			return positions
		end
		return orig_discover_positions(path)
	end
	neotest_vitest_adapter.build_spec = function(args)
		local spec = orig_build_spec(args)
		if not spec then
			return spec
		end
		local project_name = find_vitest_project_name(args.tree and args.tree:data().path)
		if project_name and spec.command then
			table.insert(spec.command, #spec.command, "--project=" .. project_name)
		end
		-- Default test timeout keeps ticking while paused in the debugger; Neotest's Vitest CLI omits --test-timeout=0.
		if args.strategy == "dap" and spec.command and #spec.command >= 2 then
			local cmd = spec.command
			table.insert(cmd, #cmd, "--test-timeout=0")
			table.insert(cmd, #cmd, "--hook-timeout=0")
			table.insert(cmd, #cmd, "--teardown-timeout=0")
			if spec.strategy and spec.strategy.type == "pwa-node" and spec.strategy.request == "launch" then
				local dap_args = {}
				for i = 2, #cmd do
					dap_args[i - 1] = cmd[i]
				end
				spec.strategy.args = dap_args
			end
		end
		if spec.strategy and spec.strategy.type == "pwa-node" then
			spec.strategy = vim.tbl_deep_extend("force", spec.strategy, vitest_js_debug_shared)
			spec.strategy.cwd = spec.cwd or spec.strategy.cwd
			spec.strategy.rootDir = spec.cwd or spec.strategy.rootDir
		end
		if spec.cwd and spec.command and #spec.command > 0 then
			local last = spec.command[#spec.command]
			if type(last) == "string" then
				spec.command[#spec.command] = relative_to_root(last, spec.cwd)
			end
			if spec.strategy and spec.strategy.type == "pwa-node" and spec.strategy.args then
				local strategy_last = spec.strategy.args[#spec.strategy.args]
				if type(strategy_last) == "string" then
					spec.strategy.args[#spec.strategy.args] = relative_to_root(strategy_last, spec.cwd)
				end
			end
		end
		return spec
	end
end

-- neotest
local neotest = require("neotest")
neotest.setup({
	adapters = {
		require("neotest-golang"),
		require("neotest-python"),
		neotest_vitest_adapter,
		require("neotest-elixir"),
	},
	output = { open_on_run = true },
	status = { virtual_text = true, signs = true },
})

-- keymaps
local map = require("utils").map
-- neotest
map("<leader>tr", neotest.run.run, "Run nearest")
map("<leader>tf", function()
	neotest.run.run(vim.fn.expand("%"))
end, "Run file")
map("<leader>ts", neotest.summary.toggle, "Toggle summary")
map("<leader>to", function()
	neotest.output.open({ enter = true })
end, "Show output")
map("<leader>td", function()
	neotest.run.run({ strategy = "dap" })
end, "Debug nearest")
map("]t", neotest.jump.next, "Jump next [t]est")
map("[t", neotest.jump.prev, "Jump previous [t]est")

-- dap
map("<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
map("<leader>dc", dap.continue, "Continue")
map("<leader>di", dap.step_into, "Step into")
map("<leader>do", dap.step_over, "Step over")
map("<leader>dO", dap.step_out, "Step out")
map("<leader>du", dapui.toggle, "Toggle UI")
map("<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Debug: Set Breakpoint Condition")

map("<F5>", dap.continue, "Debug: Start/Continue")
map("<F1>", dap.step_into, "Debug: Step Into")
map("<F2>", dap.step_over, "Debug: Step Over")
map("<F3>", dap.step_out, "Debug: Step Out")
map("<F7>", dapui.toggle, "Debug: See last session result.")
