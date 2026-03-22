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
dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close

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
	},
	trace = true,
}

for _, ft in ipairs(js_filetypes) do
	dap.configurations[ft] = {
		vim.tbl_deep_extend("force", {
			type = "pwa-node",
			request = "launch",
			name = "Debug Vitest (current file)",

			-- Better than runtimeExecutable/node + runtimeArgs for this case
			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
			args = {
				"run",
				"${file}",
				"--reporter=verbose",
				"--no-file-parallelism",
				"--test-timeout=0",
			},

			cwd = "${workspaceFolder}",
			rootDir = "${workspaceFolder}",
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
require("nvim-dap-virtual-text").setup()

-- language dap adapters
require("dap-go").setup()
require("dap-python").setup("python") -- or path to venv python

-- neotest-vitest built-in DAP spec is minimal; merge js-debug source map options so stack frames resolve to real buffer lines.
local neotest_vitest_adapter = require("neotest-vitest")({
	filter_dir = function(name, rel_path, root)
		return name ~= "node_modules"
	end,
})
do
	local orig_build_spec = neotest_vitest_adapter.build_spec
	neotest_vitest_adapter.build_spec = function(args)
		local spec = orig_build_spec(args)
		if spec and spec.strategy and spec.strategy.type == "pwa-node" then
			spec.strategy = vim.tbl_deep_extend("force", spec.strategy, vitest_js_debug_shared)
		end
		return spec
	end
end

-- neotest
require("neotest").setup({
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
local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = "Test: " .. desc })
end

-- neotest
map("<leader>tr", function()
	require("neotest").run.run()
end, "Run nearest")
map("<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, "Run file")
map("<leader>ts", function()
	require("neotest").summary.toggle()
end, "Toggle summary")
map("<leader>to", function()
	require("neotest").output.open({ enter = true })
end, "Show output")
map("<leader>td", function()
	require("neotest").run.run({ strategy = "dap" })
end, "Debug nearest")
map("]t", function()
	require("neotest").jump.next()
end, "Jump next [t]est")
map("[t", function()
	require("neotest").jump.prev()
end, "Jump previous [t]est")

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

map("<F5>", function()
	dap.continue()
end, "Debug: Start/Continue")
map("<F1>", function()
	dap.step_into()
end, "Debug: Step Into")
map("<F2>", function()
	dap.step_over()
end, "Debug: Step Over")
map("<F3>", function()
	dap.step_out()
end, "Debug: Step Out")
map("<F7>", function()
	dapui.toggle()
end, "Debug: See last session result.")
