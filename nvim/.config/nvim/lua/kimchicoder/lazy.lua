local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- nvim noice for windows and cmd tool thing
    "folke/noice.nvim",
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    --
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.0",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },

    -- Color Schemes
    "folke/tokyonight.nvim",
    "rebelot/kanagawa.nvim",
    { "catppuccin/nvim", name = "catppuccin" },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    },

    -- Status Line
        "nvim-lualine/lualine.nvim",

    -- Comment
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    -- Indent when creating new blankline
    "lukas-reineke/indent-blankline.nvim",

    -- Formatting and Linting
    "jose-elias-alvarez/null-ls.nvim",

    ---
    {
        "folke/trouble.nvim",
        lazy = true
        --    dependencies = "nvim-tree/nvim-web-devicons",
    },
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-lua/plenary.nvim",
    "ThePrimeagen/harpoon",
    "tpope/vim-fugitive",
    "mbbill/undotree",
    "onsails/lspkind.nvim",
    -- LSP Support
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },

    -- Snippets
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    "kdheepak/lazygit.nvim",

    -- {
    --     'kdheepak/tabline.nvim',
    --     config = function()
    --     end,
    --     dependencies = { { 'hoob3rt/lualine.nvim', lazy = true },
    --         { 'kyazdani42/nvim-web-devicons', lazy = true, name = "web-devicons2", } }
    -- },

    -- Debugger
    "mfussenegger/nvim-dap",
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    "jay-babu/mason-nvim-dap.nvim",

}

local opts = {}

require("lazy").setup(plugins, opts)