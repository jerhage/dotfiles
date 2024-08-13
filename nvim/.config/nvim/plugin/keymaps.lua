local set = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
set('n', '<leader>pv', vim.cmd.Ex)
set('i', 'jj', '<Esc>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- window management
set('n', '<leader>lv', '<C-w>v', { desc = 'Split window vertically' })
set('n', '<leader>lh', '<C-w>s', { desc = 'Split window horizontally' })
set('n', '<leader>le', '<C-w>=', { desc = 'Make splits equal size' })
set('n', '<leader>lx', '<cmd>close<CR>', { desc = 'Close current split' })
set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Execute the current file' })

-- Toggle hlsearch if it's on, otherwise just do "enter"
set('n', '<CR>', function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ''
  else
    return '<CR>'
  end
end, { expr = true })

-- Normally these are not good mappings, but I have left/right on my thumb
-- cluster, so navigating tabs is quite easy this way.
set('n', '<left>', 'gT')
set('n', '<right>', 'gt')

-- There are builtin keymaps for this now, but I like that it shows
-- the float when I navigate to the error - so I override them.
set('n', ']d', vim.diagnostic.goto_next)
set('n', '[d', vim.diagnostic.goto_prev)

-- These mappings control the size of splits (height/width)
set('n', '<M-,>', '<c-w>5<')
set('n', '<M-.>', '<c-w>5>')
set('n', '<M-t>', '<C-W>+')
set('n', '<M-s>', '<C-W>-')

set('n', '<M-j>', function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! ]c]]
  else
    vim.cmd [[m .+1<CR>==]]
  end
end)

set('n', '<M-k>', function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! [c]]
  else
    vim.cmd [[m .-2<CR>==]]
  end
end)

-- -- Set highlight on search, but clear on pressing <Esc> in normal mode
-- vim.opt.hlsearch = true
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
