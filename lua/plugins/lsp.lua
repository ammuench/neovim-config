return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		vim.diagnostic.config({
			float = { border = "rounded" },
		})

		local lsp_utils = require("utils.lsp")

		local default_config = {
			on_attach = lsp_utils.on_attach,
			capabilities = lsp_utils.capabilities(),
		}

		-- Simple servers (no special config)
		local simple_servers = {
			"cssls",
			"html",
			"jsonls",
			"gopls",
			"tailwindcss",
			"astro",
			"lua_ls",
			"rust_analyzer",
		}

		for _, server in ipairs(simple_servers) do
			vim.lsp.config(server, default_config)
		end
		vim.lsp.enable(simple_servers)

		-- Language-specific setups
		require("lsps.lang-typescript").setup(lsp_utils)

		-- LSP Commands
		require("utils.lsp-commands").setup(lsp_utils)
	end,
}
