require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")
		local map = require("utils").map

		local function gs_map(mode, l, r, opts)
			map(l, r, nil, mode, vim.tbl_extend("force", { buffer = bufnr }, opts or {}))
		end

		gs_map("n", "]g", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]g", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "Jump to next [g]it change" })

		gs_map("n", "[g", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[g", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Jump to previous [g]it change" })

		gs_map("v", "<leader>gs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "git [s]tage hunk" })
		gs_map("v", "<leader>gr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "git [r]eset hunk" })
		gs_map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[G]it [S]tage hunk" })
		gs_map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[G]it [R]eset hunk" })
		gs_map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[G]it [S]tage buffer" })
		gs_map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[G]it [R]eset buffer" })
		gs_map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[G]it [P]review hunk" })
		gs_map("n", "<leader>gb", gitsigns.blame_line, { desc = "[G]it [B]lame line" })
		gs_map("n", "<leader>gB", gitsigns.blame, { desc = "[G]it [B]lame file" })
		gs_map("n", "<leader>gt", gitsigns.toggle_current_line_blame, { desc = "[G]it [T]oggle - toggle blame line" })
		gs_map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
		gs_map("n", "<leader>gtD", gitsigns.preview_hunk_inline, { desc = "[T]oggle git show [D]eleted" })
	end,
})
