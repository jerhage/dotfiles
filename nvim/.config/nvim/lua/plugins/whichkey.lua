return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function() -- This is the function that runs, AFTER loading
		local wk = require("which-key")
		wk.setup()

		-- Document existing key chains
		wk.add({
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>d_", hidden = true },
			{ "<leader>f", group = "[F]ormat" },
			{ "<leader>f_", hidden = true },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>g_", hidden = true },
			{ "<leader>h", group = "[H]arpoon" },
			{ "<leader>h_", hidden = true },
			{ "<leader>l", group = "[L]sp" },
			{ "<leader>l_", hidden = true },
			{ "<leader>n", group = "[N]otifications" },
			{ "<leader>n_", hidden = true },
			-- { "<leader>r", group = "[R]ename" },
			-- { "<leader>r_", hidden = true },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>s_", hidden = true },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>w_", hidden = true },
			{ "<leader>x", group = "[X] Trouble diagnostics" },
			{ "<leader>x_", hidden = true },
			{ "gr", group = "[G]o [R]eplace" },
			{ "gr_", hidden = true },
		})
	end,
}
