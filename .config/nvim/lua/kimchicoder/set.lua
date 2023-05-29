vim.opt.shell = "zsh"
vim.opt.encoding = "UTF-8"
vim.opt.guifont = "mononoki Nerd Font"
vim.o.listchars = "tab:▸ ,eol:↲,trail:·,precedes:«,extends:»"
vim.opt.list = true
vim.opt.laststatus = 3

vim.keymap.set("i", "jj", "<Esc>")
vim.g.mapleader = " "

--vim settings
--vim.opt.path+=**
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.incsearch = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/undodir"
vim.opt.undofile = true
vim.opt.showmatch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.nu = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.scrolloff = 12
vim.opt.errorbells = false
vim.opt.hlsearch = false
vim.opt.colorcolumn = "80"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 50
-- " vim.opt.autochdir

--highlight Normal guibg=none
-- " Not working?
--highlight WinSeparator guibg=none

vim.opt.syntax = "on"
vim.opt.mouse = "a"
vim.opt.cursorline = true
