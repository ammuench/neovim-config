local lsp_commands_module = {}

lsp_commands_module.setup = function(lsp_utils)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end
      local bufnr = args.buf
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      -- ESLint Fix All (only if eslint is attached)
      if client.name == "eslint" then
        map("<Leader>L", "<cmd>EslintFixAll<cr>", "ESLint Fix All")
      end

      -- Biome Check (only if biome.json exists)
      if
        vim.fn.filereadable(vim.fn.getcwd() .. "/biome.json") == 1
        or vim.fn.filereadable(vim.fn.getcwd() .. "/biome.jsonc") == 1
      then
        vim.api.nvim_buf_create_user_command(bufnr, "BiomeCheckCurrentFile", function()
          local biome = vim.fn.getcwd() .. "/node_modules/.bin/biome"
          vim.cmd("! " .. biome .. " check % --write")
          vim.cmd("e")
        end, {})
        map("<Leader>B", "<cmd>BiomeCheckCurrentFile<cr>", "Biome Check")
      end

      -- Oxlint Fix All (only if oxlint server is attached)
      if client.name == "oxlint" then
        vim.api.nvim_buf_create_user_command(bufnr, "LspOxlintFixAll", function()
          vim.lsp.buf.code_action({
            apply = true,
            context = { only = { "source.fixAll.oxc" } },
          })
        end, {})
        map("<Leader>O", "<cmd>LspOxlintFixAll<cr>", "Oxlint Fix All")
      end
    end,
  })
end

return lsp_commands_module
