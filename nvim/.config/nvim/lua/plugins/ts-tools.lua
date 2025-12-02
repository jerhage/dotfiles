return {
	"pmizio/typescript-tools.nvim",
	requires = { "nvim-lua/plenary", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({})
	end,
}
