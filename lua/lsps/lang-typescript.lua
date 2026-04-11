local typescript_module = {}

typescript_module.setup = function(lsp_utils)
	local capabilities = lsp_utils.capabilities()

	-- vtsls
	vim.lsp.config("vtsls", {
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
		root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
	})

	-- denols
	vim.lsp.config("denols", {
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
		root_markers = { "deno.json", "deno.jsonc" },
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

	-- biome
	vim.lsp.config("biome", {
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
		root_markers = { "biome.json", "biome.jsonc" },
	})

	-- oxlint
	vim.lsp.config("oxlint", {
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
		root_markers = { ".oxlintrc.json", "oxlint.config.ts" },
	})

	-- eslint
	vim.lsp.config("eslint", {
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
		root_markers = {
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			".eslintrc.yml",
			".eslintrc.yaml",
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
		},
	})

	-- volar (Vue)
	vim.lsp.config("volar", {
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
	})

	vim.lsp.enable({ "vtsls", "denols", "biome", "oxlint", "eslint", "volar" })
end

return typescript_module
