-- This customizes the diagnostic icons seen in the Column on the left hand side
local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
