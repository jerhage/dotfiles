if not vim.pack then
	vim.api.nvim_echo({
		{ "This config expects Neovim with built-in ", "WarningMsg" },
		{ "vim.pack", "Identifier" },
		{ " (Neovim 0.12+). See :h vim.pack\n", "WarningMsg" },
	}, true, {})
	return
end

vim.pack.add({
	"https://github.com/vhyrro/luarocks.nvim",
	"https://github.com/catppuccin/nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/b0o/SchemaStore.nvim",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/Kaiser-Yang/blink-cmp-dictionary",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/rcarriga/nvim-notify",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/folke/ts-comments.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/NeogitOrg/neogit",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/echasnovski/mini.surround",
	"https://github.com/echasnovski/mini.ai",
	"https://github.com/echasnovski/mini.operators",
	-- neotest core and dependencies
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/nvim-neotest/neotest",

	-- neotest adapters
	"https://github.com/fredrikaverpil/neotest-golang",
	"https://github.com/nvim-neotest/neotest-python",
	"https://github.com/marilari88/neotest-vitest",
	"https://github.com/jfpedroza/neotest-elixir",

	-- dap core
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/nvim-neotest/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",

	-- language-specific dap adapters
	"https://github.com/leoluz/nvim-dap-go",
	"https://github.com/mfussenegger/nvim-dap-python",

	"https://github.com/jay-babu/mason-nvim-dap.nvim", -- check

	{ src = "https://github.com/mfussenegger/nvim-lint" },

	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/mikavilpas/yazi.nvim",
	"https://github.com/mrjones2014/smart-splits.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	"https://github.com/tpope/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-completion",
	"https://github.com/nvzone/showkeys",
	"https://github.com/mbbill/undotree",
}, { confirm = true })

require("luarocks-nvim").setup({})
