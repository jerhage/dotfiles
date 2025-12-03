return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]g", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next [g]it change" })

				map("n", "[g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[g", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous [g]it change" })

				-- Actions
				-- visual mode
				map("v", "<leader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "git [s]tage hunk" })
				map("v", "<leader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "git [r]eset hunk" })
				-- normal mode
				map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[G]it [S]tage hunk" })
				map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[G]it [R]eset hunk" })
				map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[G]it [S]tage buffer" })
				map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[G]it [R]eset buffer" })
				map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[G]it [P]review hunk" })
				map("n", "<leader>gb", gitsigns.blame_line, { desc = "[G]it [B]lame line" })
				map("n", "<leader>gB", gitsigns.blame, { desc = "[G]it [B]lame file" })
				map(
					"n",
					"<leader>gt",
					gitsigns.toggle_current_line_blame,
					{ desc = "[G]it [T]oggle - toggle blame line" }
				)
				map("n", "<leader>gd", gitsigns.diffthis, { desc = "[G]it [D]iff against index" })
				map("n", "<leader>gD", function()
					gitsigns.diffthis("@")
				end, { desc = "[G]it [D]iff against last commit" })
				-- Toggles
				map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
				map("n", "<leader>gtD", gitsigns.preview_hunk_inline, { desc = "[T]oggle git show [D]eleted" })

				-- map("n", "<leader>gb", function()
				-- 	gitsigns.blame_line({ full = true })
				-- end, { desc = "[Git Signs] - blame line" })
			end,
		},
	},
}
