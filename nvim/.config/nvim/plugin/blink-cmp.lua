require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

require("luasnip.loaders.from_vscode").lazy_load({})

---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<S-k>"] = { "scroll_documentation_up", "fallback" },
		["<S-j>"] = { "scroll_documentation_down", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			draw = {
				-- We don't need label_description now because label and label_description are already
				-- combined together in label by colorful-menu.nvim.
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets" },
		per_filetype = {
			sql = { "dadbod" },
			markdown = { inherit_defaults = true, "dictionary" },
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
						enable = true,
						get_command = {
							"wn",
							"${word}",
							"-over",
						},
					},
				},
			},
		},
	},
	snippets = { preset = "luasnip" },
	fuzzy = {
		implementation = "prefer_rust_with_warning",
		prebuilt_binaries = { download = true, force_version = "v1.*" },
	},
	signature = { enabled = false }, -- deferring this to noice atm
})
