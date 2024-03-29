-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"tsserver", -- ts/js
		"html", -- html
		"cssls", -- css
		"tailwindcss", -- tailwind
		"lua_ls", -- lua
		"emmet_ls", -- css, js, ts, html
		-- "ruff_lsp", -- python
		"dockerls", -- docker
		"yamlls", -- yaml
		"bashls", -- bash
		"marksman", -- markdown
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"flake8", -- python linter
		"black", -- python linter
		"isort", -- python formatter
		-- "ruff", -- python linter, formatter
		"codespell", -- fix common misspellings
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
