return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  config = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Smart Splits: " .. desc })
    end

    map("<C-h>", require("smart-splits").move_cursor_left, "Move Left")
    map("<C-j>", require("smart-splits").move_cursor_down, "Move Down")
    map("<C-k>", require("smart-splits").move_cursor_up, "Move Up")
    map("<C-l>", require("smart-splits").move_cursor_right, "Move Right")

    map("<A-h>", require("smart-splits").resize_left, "Move Left")
    map("<A-j>", require("smart-splits").resize_down, "Move Down")
    map("<A-k>", require("smart-splits").resize_up, "Move Up")
    map("<A-l>", require("smart-splits").resize_right, "Move Right")
  end,
}
