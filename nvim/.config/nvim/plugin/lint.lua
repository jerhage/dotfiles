local lint = require("lint")

local jsLinter = "oxlint"
lint.linters_by_ft = {
	javascript = { jsLinter },
	javascriptreact = { jsLinter },
	typescript = { jsLinter },
	typescriptreact = { jsLinter },
	python = { "ruff" },
	go = { "golangcilint" },
	elixir = { "credo" },
}

local function js_lint_root(bufnr)
	return vim.fs.root(bufnr, {
		".oxlintrc.json",
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
		"eslint.config.ts",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		"package.json",
	}) or vim.fn.getcwd()
end

local function go_root(bufnr)
	return vim.fs.root(bufnr, {
		"go.work",
		"go.mod",
		".git",
	}) or vim.fn.getcwd()
end

local function python_root(bufnr)
	return vim.fs.root(bufnr, {
		"pyproject.toml",
		"ruff.toml",
		".ruff.toml",
		"setup.cfg",
		"setup.py",
		".git",
	}) or vim.fn.getcwd()
end

-- shouldn't be necessary since mix handles this but just doing for consistency
local function elixir_root(bufnr)
	return vim.fs.root(bufnr, {
		"mix.exs",
		".git",
	}) or vim.fn.getcwd()
end

local augroup = vim.api.nvim_create_augroup("lint", { clear = true })
local js_lint_fts = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	group = augroup,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype

		if js_lint_fts[ft] then
			lint.try_lint(jsLinter, { cwd = js_lint_root(args.buf) })
		elseif ft == "python" then
			lint.try_lint("ruff", { cwd = python_root(args.buf) })
		elseif ft == "go" then
			lint.try_lint("golangcilint", { cwd = go_root(args.buf) })
		elseif ft == "elixir" then
			lint.try_lint("credo", { cwd = elixir_root(args.buf) })
		else
			lint.try_lint()
		end
	end,
})
