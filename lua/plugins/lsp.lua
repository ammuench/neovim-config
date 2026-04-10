return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')

    -- Shared on_attach for all servers
    local on_attach = function(client, bufnr)
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      map('<Leader>gd', vim.lsp.buf.definition, 'Go to definition')
      map('<Leader>lR', vim.lsp.buf.references, 'Show all references')
      map('K', vim.lsp.buf.hover, 'Hover docs')
      map('<Leader>la', vim.lsp.buf.code_action, 'Code actions')
      map('<Leader>lr', vim.lsp.buf.rename, 'Rename symbol')
      map('gl', vim.diagnostic.open_float, 'Hover diagnostics')
      map('<Leader>R', '<cmd>LspRestart<cr>', 'LSP Restart')
    end

    -- Shared capabilities 
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Default config applied to all servers
    local default_config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- Simple servers (no special config)
    local simple_servers = {
      'cssls',
      'html',
      'jsonls',
      'gopls',
      'tailwindcss',
      'astro',
    }

    for _, server in ipairs(simple_servers) do
      lspconfig[server].setup(default_config)
    end

    -- lua_ls (needs Neovim runtime path config)
    lspconfig.lua_ls.setup(vim.tbl_extend('force', default_config, {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME },
          },
        },
      },
    }))

    -- rust_analyzer (installed via rustup, not Mason)
    lspconfig.rust_analyzer.setup(default_config)

    -- vtsls, denols, eslint, vue — Phase 4 (need custom attach logic)
    -- lspconfig.vtsls.setup({ ... })
    -- lspconfig.denols.setup({ ... })
    -- lspconfig.eslint.setup({ ... })
    -- lspconfig.volar.setup({ ... })
  end,
}

