local installed, GitSigns = pcall(require, "gitsigns")
if not installed then
    vim.notify("Plugin 'nvim-cmp' is not installed")
    return
end

GitSigns.setup({
    signs                        = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil, -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                         = {
        enable = false
    },
    on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>gh', gs.stage_hunk, { desc = "[Git Signs] - stage hunk" })
    map('n', '<leader>gr', gs.reset_hunk, { desc = "[Git Signs] - reset hunk" })
    map('v', '<leader>gh', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "[Git Signs] - stage hunk" })
    map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "[Git Signs] - reset hunk" })
    map('n', '<leader>gS', gs.stage_buffer, { desc = "[Git Signs] - stage buffer" })
    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "[Git Signs] - undo stage hunk" })
    map('n', '<leader>gR', gs.reset_buffer, { desc = "[Git Signs] - reset buffer" })
    map('n', '<leader>gp', gs.preview_hunk, { desc = "[Git Signs] - preview hunk" })
    map('n', '<leader>gb', function() gs.blame_line{full=true} end, { desc = "[Git Signs] - blame line" })
    map('n', '<leader>gt', gs.toggle_current_line_blame, { desc = "[Git Signs] - toggle blame line" })
    map('n', '<leader>gD', gs.diffthis, { desc = "[Git Signs] - diffthis" })
    -- map('n', '<leader>hD', function() gs.diffthis('~') end)
    -- map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})