return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap
		local on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- Mappings for LSP
			if client.name == "eslint" then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							filter = function(c)
								return c.name == "eslint"
							end,
							bufnr = bufnr,
						})
					end,
				})
			end

			-- ts_ls specific bindings
			if client.name == "ts_ls" then
				keymap.set("n", "<leader>rf", ":lua vim.lsp.buf.rename()<CR>", opts)
				keymap.set(
					"n",
					"<leader>oi",
					":lua vim.lsp.buf.execute_command({ command = '_typescript.organizeImports' })<CR>",
					opts
				)
				keymap.set(
					"n",
					"<leader>ru",
					":lua vim.lsp.buf.execute_command({ command = '_typescript.removeUnused' })<CR>",
					opts
				)
			end
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
		for type, icon in pairs(signs) do
			vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
		end

		-- LSP servers setup
		local servers = {
			html = {},
			cssls = {},
			tailwindcss = {},
			dockerls = {},
			yamlls = {},
			bashls = {},
			marksman = {},
			pylsp = {},
			eslint = {
				root_dir = lspconfig.util.root_pattern(
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.json",
					".eslintrc.yaml",
					".eslintrc.yml",
					"package.json",
					".git"
				),
				settings = {
					workingDirectory = { mode = "auto" },
				},
			},

			-- ✅ Ruff LSP (new style)
			ruff = {},

			-- Lua
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},

			-- Emmet
			emmet_ls = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
			},

			-- ✅ TypeScript (no tsserver)
			ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
			},
		}

		for name, config in pairs(servers) do
			config.capabilities = capabilities
			config.on_attach = on_attach
			lspconfig[name].setup(config)
		end
	end,
}
