-- Options are loaded from init.lua before plugin/ scripts.
vim.g.have_nerd_font = true

-- Match prior lazy.nvim rtp.disabled_plugins behavior where possible
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1
vim.g.loaded_zipPlugin = 1

local opt = vim.opt
vim.cmd("let g:netrw_liststyle = 3")
----- Interesting Options -----

-- Preview substitutions live
opt.inccommand = "split"

-- Search settings
opt.smartcase = true
opt.ignorecase = true

opt.number = true
opt.relativenumber = false

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = "unnamedplus"

-- Don't have `o` add a comment
opt.formatoptions:remove("o")

opt.number = true
opt.mouse = "a"

opt.showmode = true

opt.breakindent = true

opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

opt.background = "dark"
opt.signcolumn = "yes"

opt.updatetime = 250
opt.timeoutlen = 300

opt.splitright = true
opt.splitbelow = true

opt.list = false -- disabled because it was overriding plugin indent-blankline.lua
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.expandtab = true
opt.autoindent = true
opt.backspace = "indent,eol,start"
opt.cursorline = true
opt.tabstop = 4

opt.scrolloff = 10
opt.shiftwidth = 4

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true
