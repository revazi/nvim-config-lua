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

			-- LSP keymaps
			keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
			keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
			keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
			keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
			keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
			keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
			keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

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
			eslint = {},

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
