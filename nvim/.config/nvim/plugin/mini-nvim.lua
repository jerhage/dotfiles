require("mini.surround").setup({})

local ai = require("mini.ai")
ai.setup({
	n_lines = 200,
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

require("mini.operators").setup({ exchange = { prefix = "ge" } })
