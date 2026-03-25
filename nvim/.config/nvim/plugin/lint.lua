local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	python = { "ruff" },
	go = { "golangcilint" },
	elixir = { "credo" },
}

local function eslint_root(bufnr)
	return vim.fs.root(bufnr, {
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
local eslint_fts = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	group = augroup,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype

		if eslint_fts[ft] then
			lint.try_lint("eslint_d", { cwd = eslint_root(args.buf) })
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

local map = require("utils").map
-- INFO: eslint_d can become stale when switching between branches. Use if receiving diagnostics that seem off.
map("<leader>lE", function()
	local ok, err = pcall(vim.fn.system, { "eslint_d", "restart" })
	if ok and vim.v.shell_error == 0 then
		vim.notify("eslint_d restarted", vim.log.levels.INFO)
	else
		vim.notify("eslint_d restart failed: " .. (err or vim.fn.system("eslint_d restart")), vim.log.levels.ERROR)
	end
end, "Restart eslint_d")
