-- requiring necessary plugins
-- mason
local installed, Mason = pcall(require, "mason")
if not installed then
	vim.notify("Plugin 'mason' not installed ")
	return
end

-- Mason lspconfig
local installed, MasonLspConfig = pcall(require, "mason-lspconfig")
if not installed then
	vim.notify("Plugin 'mason-lspconfig' not installed ")
	return
end

-- Mason nvim dap
local installed, MasonNvimDap = pcall(require, "mason-nvim-dap")
if not installed then
	vim.notify("Plugin 'mason-nvim-dap' not installed ")
	return
end

-- Mason tool installer
local installed, MasonToolInstaller = pcall(require, "mason-tool-installer")
if not installed then
	vim.notify("Plugin 'mason-tool-installer' not installed ")
	return
end

-- #############################################################################
-- Lsp config
local installed, LspConfig = pcall(require, "lspconfig")
if not installed then
	vim.notify("Plugin 'lspconfig' not installed ")
	return
end

-- cmp_nvim_lsp
local installed, CmpNvimLsp = pcall(require, "cmp_nvim_lsp")
if not installed then
	vim.notify("Plugin 'cmp-nvim-lsp' not installed ")
	return
end

-- #############################################################################
-- Setting up plugins

Mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Masong Lsp config

MasonLspConfig.setup({
	ensure_installed = {
		"lua_ls",
		"cssls",
		"marksman",
	},
})

-- Mason automatically installs required tools for nvim-dap
MasonNvimDap.setup({
	ensure_installed = { "python", "stylua" },
	handlers = {}, -- sets up dap in the predefined manner
})

-- Mason Tool Installer
MasonToolInstaller.setup({
	-- a list of all tools you want to ensure are installed upon
	-- start; they should be the names Mason uses for each tool
	ensure_installed = {
		-- you can turn off/on auto_update per tool
		{ "bash-language-server", auto_update = true },
		{ "lua-language-server", auto_update = true },
		{ "vim-language-server", auto_update = true },
		{ "stylua", auto_update = true },
		{ "editorconfig-checker" },
		{ "html-lsp" },
		{ "css-lsp" },
		{ "pyright" },
		{ "black" },
		{ "autopep8" },
		{ "json-lsp" },
		{ "prettier" },
	},

	auto_update = false,
	run_on_start = true,
	start_delay = 3000, -- 3 second delay
	debounce_hours = 5, -- at least 5 hours between attempts to install/update
})

-- #############################################################################
-- Managing language servers individually

local capabilities = CmpNvimLsp.default_capabilities()

-- pyright
-- LspConfig.pyright.setup({
-- 	capabilities = capabilities,
-- })
-- tsserver
LspConfig.tsserver.setup({
	capabilities = capabilities,
})
-- rust_analyzer
LspConfig.rust_analyzer.setup({
	capabilities = capabilities,
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		["rust-analyzer"] = {},
	},
})

-- html
LspConfig.html.setup({
	capabilities = capabilities,
})

-- Lua LS
LspConfig.lua_ls.setup({
	capabilities = capabilities,
})

-- CSS LS
LspConfig.cssls.setup({
	capabilities = capabilities,
})

-- Tailwind
-- Support for tailwind auto completion
-- install the tailwind server : "sudo npm install -g @tailwindcss/language-server"
LspConfig.tailwindcss.setup({
	capabilities = capabilities,
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[LSP] Definition" })
-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "" })
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = "[LSP] Workspace Symbol" })
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = "[LSP] Open Float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = "[LSP] Go to Next" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = "[LSP] Go to Previous" })
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { desc = "[LSP] Code Action" })
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { desc = "[LSP] References" })
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "[LSP] Rename" })
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "[LSP] Signature Help" })
