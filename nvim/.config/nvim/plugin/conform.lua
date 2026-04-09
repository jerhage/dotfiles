vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

---@module "conform"
---@type conform.setupOpts
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		elixir = { "lexical" },
		heex = { "elixir-ls" },
		python = { "isort", "black" },
		javascript = { "oxfmt", "oxlint", "eslint", stop_after_first = true },
		typescript = { "oxfmt", "oxlint", "eslint", stop_after_first = true },
		javascriptreact = { "oxfmt", "oxlint", "eslint", stop_after_first = true },
		typescriptreact = { "oxfmt", "oxlint", "eslint", stop_after_first = true },
		svelte = { "eslint", "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		graphql = { "prettierd", "prettier", stop_after_first = true },
		liquid = { "prettierd", "prettier", stop_after_first = true },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2" },
		},
	},
})

local map = require("utils").map

map("<leader>ff", function()
	require("conform").format({ async = true })
end, "Format buffer", { "n", "v" })
