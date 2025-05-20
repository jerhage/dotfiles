return {
	{
		"echasnovski/mini.surround",
		enabled = true,
		version = "*",
		opts = {},
		config = function()
			require("mini.surround").setup({})
		end,
	},
	{
		"echasnovski/mini.ai",
		enabled = true,
		version = "*",
		config = function()
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 200,

				-- MUST HAVE TREESITTER-TEXTOBJ INSTALLED AND ENABLED FOR THESE TO WORK
				-- https://github.com/echasnovski/mini.nvim/issues/947#issuecomment-2154242659
				custom_textobjects = {
					a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					F = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }),
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
				},
			})
		end,
	},
	{
		"echasnovski/mini.operators",
		version = "*",
		enabled = true,
		config = function()
			require("mini.operators").setup({ exchange = { prefix = "ge" } })
		end,
	},
}
