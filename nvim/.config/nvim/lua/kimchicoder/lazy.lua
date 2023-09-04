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
    { "nvim-tree/nvim-web-devicons" },
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.0",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },

    -- Color Schemes
    { "folke/tokyonight.nvim",      lazy = true },
    { "rebelot/kanagawa.nvim",      lazy = true },
    { "catppuccin/nvim",            name = "catppuccin" },
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
    { "lukas-reineke/indent-blankline.nvim", lazy = true },

    -- Formatting and Linting
    { "jose-elias-alvarez/null-ls.nvim",     lazy = true },

    ---
    {
        "folke/trouble.nvim",
        lazy = true
        --    dependencies = "nvim-tree/nvim-web-devicons",
    },
    "nvim-treesitter/nvim-treesitter",
    { "nvim-treesitter/playground", lazy = true },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-lua/plenary.nvim",
    "ThePrimeagen/harpoon",
    { "tpope/vim-fugitive" },
    { "mbbill/undotree"},
    "onsails/lspkind.nvim",
    -- LSP Support
    --    { "neovim/nvim-lspconfig" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } }
            }
        },
        -- your lsp config or other stuff
    },
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
    { "L3MON4D3/LuaSnip",                         lazy = true },
    { "rafamadriz/friendly-snippets",             lazy = true },
    { "kdheepak/lazygit.nvim",                    lazy = true },

    -- {
    --     'kdheepak/tabline.nvim',
    --     config = function()
    --     end,
    --     dependencies = { { 'hoob3rt/lualine.nvim', lazy = true },
    --         { 'kyazdani42/nvim-web-devicons', lazy = true, name = "web-devicons2", } }
    -- },

    -- Debugger
    { "mfussenegger/nvim-dap" },
    { 'rcarriga/nvim-dap-ui',                     lazy = true },
    { 'theHamsta/nvim-dap-virtual-text',          lazy = true },
    { "jay-babu/mason-nvim-dap.nvim" },

    -- Top bar showing location in project/file
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    }

}


local opts = {}

require("lazy").setup(plugins, opts)
