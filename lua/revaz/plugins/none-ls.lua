return {
	"nvimtools/none-ls.nvim",
	name = "null-ls",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local code_actions = null_ls.builtins.code_actions

		vim.notify("✅ null-ls plugin loaded!", vim.log.levels.INFO)

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

		local sources = {
			-- JS/TS formatting
			formatting.prettier.with({
				filetypes = { "javascript", "typescript", "json", "css", "scss", "html", "vue" },
			}),

			-- Lua
			formatting.stylua,

			-- Python
			formatting.black.with({
				extra_args = function()
					local path = find_project_root({ "pyproject.toml" })
					return path and { "--config", path } or {}
				end,
			}),
			formatting.isort.with({
				extra_args = function()
					local path = find_project_root({ "pyproject.toml" })
					return path and { "--settings-path", path } or {}
				end,
			}),

			-- Misc
			diagnostics.djlint,
			diagnostics.editorconfig_checker,
			diagnostics.dotenv_linter,
			diagnostics.ansiblelint,
			code_actions.gitsigns,
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(c)
									return c.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end,
		})
	end,
}
