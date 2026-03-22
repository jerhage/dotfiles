local install_dir = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "site")

require("nvim-treesitter").setup({
	install_dir = install_dir,
})

-- Parser names for :TSInstall / install(); see nvim-treesitter SUPPORTED_LANGUAGES.md
local parsers = {
	"bash",
	"elixir",
	"heex",
	"eex",
	"html",
	"css",
	"lua",
	"markdown",
	"markdown_inline",
	"yaml",
	"vim",
	"vimdoc",
	"go",
	"templ",
	"javascript",
	"typescript",
	"jsx",
	"tsx",
}

-- Install after UI is up so startup is not blocked on first run.
vim.defer_fn(function()
	pcall(function()
		require("nvim-treesitter").install(parsers):wait(300000)
	end)
end, 0)

-- Highlighting + experimental indent (see :h nvim-treesitter README)
local fts = {
	"bash",
	"sh",
	"zsh",
	"elixir",
	"heex",
	"eelixir",
	"eex",
	"html",
	"css",
	"lua",
	"markdown",
	"yaml",
	"vim",
	"help",
	"go",
	"templ",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = fts,
	callback = function(ev)
		if pcall(vim.treesitter.start, ev.buf) then
			vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

require("nvim-ts-autotag").setup({})
