" Source whatever you need
source $HOME/.vimrc

" Get plugins first so subsequet settings depending on plugins work
call plug#begin('~/.config/nvim/plugged')

" Theming
Plug 'gruvbox-community/gruvbox'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep' " Dependency of live_grep

" Git root
Plug 'airblade/vim-rooter'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'L3MON4D3/LuaSnip'

Plug 'junegunn/fzf', { 'do': {-> fzf#install()} }
Plug 'junegunn/fzf.vim'

" Display color of hexvalues
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

colorscheme gruvbox

" Lua stuff
lua require("kimchicoder")

" Lsp Installer config
" Need to set up options
lua <<EOF
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)
EOF

" Supress Lsp error messages
lua <<EOF
vim.notify = function(msg, log_level, _opts)
    if msg:match("exit code") then
        return
    end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end
EOF


" Remaps with dependencies on plugins
" nnoremap <leader>fg :lua require('telescope.builtin').git_files()<CR>
" nnoremap <leader>ff :lua require('telescope.builtin').live_grep({grep_open_files=true})<cr>
" nnoremap <leader>fs :lua require('telescope.builtin').grep_string()<CR>
" nnoremap <leader>df :lua require('telescope.builtin').lsp_definitions({jump_type = "never"})<CR>
" nnoremap <leader>fu :lua require('telescope.builtin').lsp_references()<CR>
" nnoremap <leader>fif :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>

nnoremap <leader>fg :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>ff :lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h') })<cr>
nnoremap <leader>fF :lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>df :lua require('telescope.builtin').lsp_definitions({jump_type = "never"})<CR>
nnoremap <leader>fu :lua require('telescope.builtin').lsp_references()<CR>
nnoremap <leader>faf :lua require('telescope.builtin').live_grep({grep_open_files=true, cwd = vim.fn.expand('%:p:h')})<cr>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string()<CR>
nnoremap <leader>fif :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>

" Cd to current buffer + print
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Consider consolidating all vim.lsp fns to lspconfig.lua
nnoremap <leader>def :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>for :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>hi :lua vim.lsp.buf.document_highlight()<CR>
" nnoremap <leader>fa :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>ca  :lua vim.lsp.buf.code_action()<CR>
