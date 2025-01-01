return {
	"neovim/nvim-lspconfig",
	config = function()
		-- LSP Configuration
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			cmd = { "rust-analyzer" },
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			cmd = { "lua-language-server" },
		})
		lspconfig.html.setup({
			capabilities = capabilities,
		})
		lspconfig.nixd.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				client.server_capabilities.semanticTokensProvider = nil
			end,
		})

		local lsp = vim.lsp
		lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})
		lsp.handlers["textDocument/signature"] = lsp.with(vim.lsp.handlers.signature_help, {
			border = "single",
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Action" })
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
				vim.keymap.set(
					"n",
					"<leader>cs",
					vim.lsp.buf.document_symbol,
					{ buffer = event.buf, desc = "Document Symbol" }
				)
				vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover" })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Goto Definition" })
				vim.keymap.set(
					"n",
					"<C-s>",
					vim.lsp.buf.signature_help,
					{ buffer = event.buf, desc = "Goto Definition" }
				)
				vim.keymap.set(
					"i",
					"<C-s>",
					vim.lsp.buf.signature_help,
					{ buffer = event.buf, desc = "Goto Definition" }
				)
			end,
		})
	end,
}
