return {
	"elixir-tools/elixir-tools.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local elixir = require("elixir")
		local elixirls = require("elixir.elixirls")

		elixir.setup({
			nextls = { enable = true },
			elixirls = {
				enable = true,
				settings = elixirls.settings({
					dialyzerEnabled = false,
					enableTestLenses = true,
				}),
				on_attach = function(client, bufnr)
					vim.keymap.set(
						"n",
						"<space>fp",
						":ElixirFromPipe<cr>",
						{ buffer = true, noremap = true, desc = "[F]rom [P]ipe" }
					)
					vim.keymap.set(
						"n",
						"<space>tp",
						":ElixirToPipe<cr>",
						{ buffer = true, noremap = true, desc = "[T]o [P]ipe" }
					)
					vim.keymap.set(
						"v",
						"<space>em",
						":ElixirExpandMacro<cr>",
						{ buffer = true, noremap = true, desc = "[E]xpand Macro" }
					)
					vim.keymap.set(
						"n",
						"grR",
						":lua vim.lsp.codelens.run()<cr>",
						{ buffer = true, noremap = true, desc = "[G]o [R]un Codelens" }
					)
				end,
			},
			projectionist = {
				enable = true,
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
