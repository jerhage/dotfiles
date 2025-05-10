return { -- Autocompletion
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		-- Snippet Engine
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
			-- 'default' (recommended) for mappings similar to built-in completions
			--   <c-y> to accept ([y]es) the completion.
			--    This will auto-import if your LSP supports it.
			--    This will expand snippets if the LSP sent a snippet.
			-- 'super-tab' for tab to accept
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- For an understanding of why the 'default' preset is recommended,
			-- you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			--
			-- All presets have the following mappings:
			-- <tab>/<s-tab>: move to right/left of your snippet expansion
			-- <c-space>: Open menu or open docs if already open
			-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
			-- <c-e>: Hide menu
			-- <c-k>: Toggle signature help
			--
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
			-- By default, you may press `<c-space>` to show the documentation.
			-- Optionally, set `auto_show = true` to show the documentation after a delay.
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},

		sources = {
			default = { "lsp", "path", "snippets", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					score_offset = 20, -- the higher the number, the higher the priority
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

		-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
		-- which automatically downloads a prebuilt binary when enabled.
		--
		-- By default, we use the Lua implementation instead, but you may enable
		-- the rust implementation via `'prefer_rust_with_warning'`
		--
		-- See :h blink-cmp-config-fuzzy for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },

		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	},
}
-- return {
--   "saghen/blink.cmp",
--   event = "InsertEnter",
--   dependencies = {
--     "rafamadriz/friendly-snippets",
--     "moyiz/blink-emoji.nvim",
--     "Kaiser-Yang/blink-cmp-dictionary",
--   },
--   lazy = false,
--   version = "v0.*",
--   opts = {
--     appearance = {
--       use_nvim_cmp_as_default = false,
--       nerd_font_variant = "mono",
--     },
--     completion = {
--       accept = {
--         auto_brackets = {
--           enabled = true,
--         },
--       },
--       -- menu = {
--       --   draw = {
--       --     treesitter = { "lsp" },
--       --   },
--       -- },
--       menu = {
--         border = "single",
--       },
--       documentation = {
--         auto_show = true,
--         auto_show_delay_ms = 200,
--         window = {
--           border = "single",
--         },
--       },
--       ghost_text = {
--         enabled = true,
--       },
--     },
--
--     cmdline = {
--       enabled = false,
--     },
--     sources = {
--       default = { "lsp", "path", "snippets", "buffer", "emoji" },
--       providers = {
--
--         emoji = {
--           module = "blink-emoji",
--           name = "Emoji",
--           score_offset = 15, -- the higher the number, the higher the priority
--           opts = { insert = true }, -- Insert emoji (default) or complete its name
--         },
--         -- https://github.com/Kaiser-Yang/blink-cmp-dictionary
--         -- On macOS to get started with a dictionary:
--         -- cp /usr/share/dict/words ~/.config/dictionaries
--         dictionary = {
--           module = "blink-cmp-dictionary",
--           name = "Dict",
--           score_offset = 20,
--           enabled = true,
--           max_items = 8,
--           min_keyword_length = 3,
--           opts = {
--             get_command = {
--               "rg",
--               "--color=never",
--               "--no-line-number",
--               "--no-messages",
--               "--no-filename",
--               "--ignore-case",
--               "--",
--               "${prefix}", -- this will be replaced by the result of 'get_prefix' function
--               vim.fn.expand("~/.config/dictionaries/words"), -- where you dictionary is
--             },
--             documentation = {
--               enable = true, -- enable documentation to show the definition of the word
--               get_command = {
--                 -- For the word definitions feature
--                 -- make sure "wn" is available in your system
--                 -- brew install wordnet
--                 "wn",
--                 "${word}", -- this will be replaced by the word to search
--                 "-over",
--               },
--             },
--           },
--         },
--       },
--     },
--
--     snippets = {
--       preset = "luasnip",
--       -- This comes from the luasnip extra, if you don't add it, won't be able to
--       -- jump forward or backward in luasnip snippets
--       -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
--       expand = function(snippet)
--         require("luasnip").lsp_expand(snippet)
--       end,
--       active = function(filter)
--         if filter and filter.direction then
--           return require("luasnip").jumpable(filter.direction)
--         end
--         return require("luasnip").in_snippet()
--       end,
--       jump = function(direction)
--         require("luasnip").jump(direction)
--       end,
--     },
--
--     keymap = {
--       preset = "enter",
--       ["<Tab>"] = { "snippet_forward", "fallback" },
--       ["<S-Tab>"] = { "snippet_backward", "fallback" },
--
--       ["<Up>"] = { "select_prev", "fallback" },
--       ["<Down>"] = { "select_next", "fallback" },
--       ["<C-p>"] = { "select_prev", "fallback" },
--       ["<C-n>"] = { "select_next", "fallback" },
--
--       ["<C-b>"] = { "scroll_documentation_up", "fallback" },
--       ["<C-f>"] = { "scroll_documentation_down", "fallback" },
--
--       ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
--       ["<C-e>"] = { "hide", "fallback" },
--     },
--   },
-- }
