-- Useful plugin to show you pending keybinds.
return {
	"folke/which-key.nvim",
	event = "VeryLazy", -- Sets the loading event to 'VeryLazy'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").add({
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
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>r_", hidden = true },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>s_", hidden = true },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>w_", hidden = true },
			{ "<leader>x", group = "[X] Trouble diagnostics" },
			{ "<leader>x_", hidden = true },
			{ "gr", group = "[G]o to" },
			{ "gr_", hidden = true },
		})

		-- require('which-key').register {
		--   { '', group = '[D]ocument' },
		--   { '', group = '[C]ode' },
		--   { '', group = '[S]earch' },
		--   { '', group = '[R]ename' },
		--   { '', group = '[W]orkspace' },
		--   { '', desc = '', hidden = true, mode = { 'n', 'n', 'n', 'n', 'n' } },
		-- }
	end,
}
