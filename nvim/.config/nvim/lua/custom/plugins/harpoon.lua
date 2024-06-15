-- vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
    local set = vim.keymap.set

    set('n', '<leader>hm', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon: [M]ark' })
    set('n', '<leader>hl', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H]arpoon: [L]ist' })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      set('n', string.format('<space>h%d', idx), function()
        harpoon:list():select(idx)
      end, { desc = string.format('[H]arpoon: navigate to %d', idx) })
    end
  end,
}
