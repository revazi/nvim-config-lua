-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")

if not setup then
	return
end

local function find_project_root(file_names)
	local lsp_util = require("lspconfig/util")
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)

	local root = lsp_util.find_git_ancestor(bufname) or lsp_util.path.dirname(bufname)
	if root then
		for _, fname in ipairs(file_names) do
			local full_path = lsp_util.path.join(root, fname)
			if lsp_util.path.is_file(full_path) then
				return full_path
			end
		end
	end
	return nil
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local code_actions = null_ls.builtins.code_actions

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		-- formatting.black,
		-- formatting.isort,
		diagnostics.djlint,
		diagnostics.editorconfig_checker,
		diagnostics.dotenv_linter,
		diagnostics.ansiblelint,
		code_actions.gitsigns,
		-- null_ls.builtins.diagnostics.eslint_d.with({
		--     -- ignore prettier warnings from eslint-plugin-prettier
		--     filter = function(diagnostic)
		--         return diagnostic.code ~= "prettier/prettier"
		--     end,
		-- }),
		diagnostics.eslint_d.with({ -- js/ts linter
			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.cjs") -- change file extension if you use something else
			end,
			-- ignore prettier warnings from eslint-plugin-prettier
			filter = function(diagnostic)
				return diagnostic.code ~= "prettier/prettier"
			end,
		}),
		-- --  to disable file types use
		-- --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettier.with({ filetypes = { "javascript", "typescript", "json", "css", "scss", "html", "vue" } }), -- js/ts formatter
		formatting.stylua, -- lua formatter
		-- read config for flake8 from current project pyproject.toml
		-- formatting.flake8,
		diagnostics.flake8.with({
			extra_args = function(params)
				local flake8_config = find_project_root({ "pyproject.toml" })
				if flake8_config then
					return { "--config", flake8_config }
				end
				return {}
			end,
		}),
		-- formatting.flake8.with({
		--
		-- 	extra_args = function(utils)
		-- 		local flake8_config = find_project_root("pyproject.toml")
		-- 		if flake8_config then
		-- 			return { "--config", flake8_config }
		-- 		end
		-- 		return {}
		-- 	end,
		-- }),
		formatting.black.with({
			extra_args = function(params)
				local pyproject_toml = find_project_root({ "pyproject.toml" })
				if pyproject_toml then
					return { "--config", pyproject_toml }
				end
				return {}
			end,
		}),
		formatting.isort.with({
			extra_args = function(params)
				local pyproject_toml = find_project_root({ "pyproject.toml" })
				if pyproject_toml then
					return { "--settings-path", pyproject_toml }
				end
				return {}
			end,
		}),
		-- formatting.black.with({
		-- 	extra_args = function(utils)
		-- 		local pyproject_toml = utils.root_has_file("pyproject.toml")
		-- 		if pyproject_toml then
		-- 			return { "--config", pyproject_toml }
		-- 		end
		-- 		return {}
		-- 	end,
		-- }),
		-- formatting.isort.with({
		-- 	extra_args = function(utils)
		-- 		local pyproject_toml = utils.root_has_file("pyproject.toml")
		-- 		if pyproject_toml then
		-- 			return { "--settings-path", pyproject_toml }
		-- 		end
		-- 		return {}
		-- 	end,
		-- }),
		--   diagnostics.eslint_d.with({ -- js/ts linter
		-- 	-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
		-- 	condition = function(utils)
		-- 		return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.cjs") -- change file extension if you use something else
		-- 	end,
		-- }),
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							-- print the client name to see what it is
							-- print("client name: ")
							-- print(client.name)
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
