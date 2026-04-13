local typescript_module = {}

typescript_module.setup = function(lsp_utils)
  local capabilities = lsp_utils.capabilities()

  -- vue_ls requires vtsls to be running with the @vue/typescript-plugin
  -- registered as a global plugin so it can forward TS requests.
  -- See: https://github.com/vuejs/language-tools/wiki/Neovim
  local vue_language_server_path = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

  -- vtsls
  vim.lsp.config("vtsls", {
    on_attach = lsp_utils.on_attach,
    capabilities = capabilities,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "vue" },
              configNamespace = "typescript",
            },
          },
        },
      },
    },
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

  -- NOTE: ESLint is handled by the nvim-eslint plugin (esmuellert/nvim-eslint).
  -- Do NOT add an eslint config here — it will conflict with the plugin's LSP client.

  -- vue_ls (Vue)
  vim.lsp.config("vue_ls", {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json" },
    on_attach = lsp_utils.on_attach,
    capabilities = capabilities,
    on_init = function(client)
      client.handlers["tsserver/request"] = function(_, result, context)
        local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
        if #clients == 0 then
          return
        end

        local ts_client = clients[1]
        local param = unpack(result)
        local id, command, payload = unpack(param)
        ts_client:exec_cmd({
          title = "vue_request_forward",
          command = "typescript.tsserverRequest",
          arguments = { command, payload },
        }, { bufnr = context.bufnr }, function(_, r)
          local response = r and r.body
          local response_data = { { id, response } }
          ---@diagnostic disable-next-line: param-type-mismatch
          client:notify("tsserver/response", response_data)
        end)
      end
    end,
  })

  vim.lsp.enable({ "vtsls", "denols", "biome", "oxlint", "vue_ls" })
end

return typescript_module
