local lsp_module = {}

lsp_module.on_attach = function(client, bufnr)
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

lsp_module.capabilities = function()
  return require('blink.cmp').get_lsp_capabilities()
end

return lsp_module
