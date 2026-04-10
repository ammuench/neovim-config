local typescript_module = {}

typescript_module.setup = function(lsp_utils)
	local lspconfig = require("lspconfig")
	local capabilities = lsp_utils.capabilities()

	-- vtsls
	lspconfig.vtsls.setup({
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
	})

	-- denols
	lspconfig.denols.setup({
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
		root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
	})

	-- Deno ↔ vtsls switcher
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then
				return
			end
			local bufnr = args.buf

			if client.name == "denols" then
				for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr, name = "vtsls" })) do
					vim.lsp.stop_client(c.id, true)
				end
			end

			if client.name == "vtsls" then
				if #vim.lsp.get_clients({ bufnr = bufnr, name = "denols" }) > 0 then
					vim.lsp.stop_client(client.id, true)
				end
			end
		end,
	})

	-- eslint
	lspconfig.eslint.setup({
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
	})

	-- volar (Vue)
	lspconfig.volar.setup({
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
	})
end

return typescript_module
