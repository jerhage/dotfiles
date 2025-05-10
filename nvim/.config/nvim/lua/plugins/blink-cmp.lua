return {
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").load()
					end,
				},
			},
			opts = {},
		},
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		"Kaiser-Yang/blink-cmp-dictionary",
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			-- Read `:help ins-completion` for logic around keymap defaults.
			-- See :h blink-cmp-config-keymap for defining your own keymap
			preset = "default",
			["<S-k>"] = { "scroll_documentation_up", "fallback" },
			["<S-j>"] = { "scroll_documentation_down", "fallback" },
			-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
			--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},

		sources = {
			default = { "lsp", "path", "snippets" },
			per_filetype = {
				sql = { "dadbod" },
				markdown = { inherit_defaults = true, "dictionary" },
				-- optionally inherit from the `default` sources
				lua = { inherit_defaults = true, "lazydev" },
			},
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				dadbod = { module = "vim_dadbod_completion.blink" },
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					score_offset = 20,
					enabled = true,
					max_items = 8,
					min_keyword_length = 3,
					opts = {
						dictionary_directories = { vim.fn.expand("~/.config/nvim/dictionaries") },
						dictionary_files = {
							vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
						},

						documentation = {
							enable = true, -- enable documentation to show the definition of the word
							get_command = {
								-- For the word definitions feature
								-- make sure "wn" is available in your system
								-- brew install wordnet
								"wn",
								"${word}", -- this will be replaced by the word to search
								"-over",
							},
						},
					},
				},
			},
		},

		snippets = { preset = "luasnip" },
		-- See :h blink-cmp-config-fuzzy for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	},
}
