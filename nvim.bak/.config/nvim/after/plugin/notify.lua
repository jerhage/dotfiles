vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if not (result and result.contents) then
    return
  end
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
  if vim.tbl_isempty(markdown_lines) then
    return
  end
  return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
end
-- return {
--   "rcarriga/nvim-notify",
--   config = function()
--     -- See https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-1297599534
--     -- An alternative solution: https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
--     local banned_messages = { "No information available" }
--     vim.notify = function(msg, ...)
--       for _, banned in ipairs(banned_messages) do
--         if msg == banned then
--           return
--         end
--       end
--       return require("notify")(msg, ...)
--     end
--   end,
-- }
