-- Must run before any vim.pack.add() so install/update hooks fire. See :h vim.pack-events
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		local opt = vim.fn.stdpath("data") .. "/site/pack/core/opt/" .. name

		if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
			vim.system({ "make", "-C", opt }, { text = true }):wait()
			return
		end

		if name == "LuaSnip" and vim.fn.has("win32") == 0 and vim.fn.executable("make") == 1 then
			vim.system({ "make", "-C", opt, "install_jsregexp" }, { text = true }):wait()
			return
		end

		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end

		if name == "fff.nvim" and (kind == "install" or kind == "update") then
			require("fff.download").download_or_build_binary()
		end
	end,
})
