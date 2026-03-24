require("mason").setup()
local map = require("utils").map
map("<leader>lR", "<cmd>lsp restart<cr>", "[L]SP [R]estart")

local lsp_info = function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	if #clients == 0 then
		vim.notify("No LSP clients attached to this buffer", vim.log.levels.WARN)
		return
	end

	local lines = {}
	for _, client in ipairs(clients) do
		table.insert(lines, string.format("Client: %s (id: %d)", client.name, client.id))
		table.insert(lines, string.format("  Root:  %s", client.root_dir or "none"))
		table.insert(lines, string.format("  Cmd:   %s", table.concat(client.config.cmd or {}, " ")))
		table.insert(lines, "")
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].filetype = "markdown"
	vim.cmd.sbuffer(buf)
end

vim.api.nvim_create_user_command("LspInfo", lsp_info, {})

-- LspAttach: keymaps, highlights, inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kimchi-lsp-attach", { clear = true }),
	callback = function(event)
		map("<leader>cr", vim.lsp.buf.rename, "LSP: [C]ode [R]ename", nil, { buffer = event.buf })
		map("<leader>ca", vim.lsp.buf.code_action, "LSP: [C]ode [A]ction", { "n", "x" }, { buffer = event.buf })

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local group = vim.api.nvim_create_augroup("kimchi-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = group,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = group,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(
					not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
					{ bufnr = event.buf }
				)
			end, "LSP: [T]oggle Inlay [H]ints", nil, { buffer = event.buf })
		end
	end,
})

vim.diagnostic.config({
	severity_sort = true,
	virtual_text = { source = "if_many", spacing = 2 },
	float = { border = "rounded", source = "if_many" },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

local servers = {
	bashls = {
		cmd = { "bash-language-server", "start" },
		filetypes = { "bash", "sh" },
		root_markers = { ".git" },
	},
	gopls = {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
	},
	astro = {
		cmd = { "astro-ls", "--stdio" },
		filetypes = { "astro" },
		root_markers = { "package.json", "tsconfig.json", ".git" },
	},
	cssls = {
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "less", "scss" },
		root_markers = { "package.json", ".git" },
	},
	html = {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html" },
		root_markers = { "package.json", ".git" },
	},
	ts_ls = {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	},
	marksman = {
		cmd = { "marksman", "server" },
		filetypes = { "markdown", "markdown.mdx" },
		root_markers = { ".marksman.toml", ".git" },
	},
	pyright = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	},
	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
				},
				diagnostics = {
					globals = { "vim" },
					disable = { "missing-fields" },
				},
			},
		},
	},
	jsonls = {
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
		root_markers = { ".git" },
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	yamlls = {
		cmd = { "yaml-language-server", "--stdio" },
		filetypes = { "yaml", "yaml.docker-compose" },
		root_markers = { ".git" },
		settings = {
			yaml = {
				schemaStore = { enable = false, url = "" },
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
}

vim.lsp.config("expert", {
	cmd = { "expert" },
	root_markers = { "mix.exs", ".git" },
	filetypes = { "elixir", "eelixir", "heex" },
	capabilities = capabilities,
})
vim.lsp.enable("expert")

for name, cfg in pairs(servers) do
	cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
	vim.lsp.config(name, cfg)
	vim.lsp.enable(name)
end

require("mason-tool-installer").setup({
	ensure_installed = {
		"bash-language-server",
		"gopls",
		"astro-language-server",
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"marksman",
		"pyright",
		"lua-language-server",
		"json-lsp",
		"yaml-language-server",
		"stylua",
		"eslint_d",
		"prettierd",
		"js-debug-adapter",
	},
})
