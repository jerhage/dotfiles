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

-- dap-ui opens/closes automatically on dap events
local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

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

-- Vitest-specific configuration
local js_filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
for _, ft in ipairs(js_filetypes) do
	dap.configurations[ft] = {
		-- Debug a single test file under vitest
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Vitest (current file)",
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/vitest/vitest.mjs",
				"run",
				"--reporter=verbose",
				"--no-file-parallelism",
			},
			args = { "${file}" },
			rootDir = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			sourceMaps = true,
		},
		-- Attach to an already-running vitest process
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Vitest",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			sourceMaps = true,
		},
	}
end

-- inline variable values while stepping
require("nvim-dap-virtual-text").setup()

-- language dap adapters
require("dap-go").setup()
require("dap-python").setup("python") -- or path to venv python

-- neotest
require("neotest").setup({
	adapters = {
		require("neotest-golang"),
		require("neotest-python"),
		-- helps find tests in mono repo
		require("neotest-vitest")({
			filter_dir = function(name, rel_path, root)
				return name ~= "node_modules"
			end,
		}),
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

