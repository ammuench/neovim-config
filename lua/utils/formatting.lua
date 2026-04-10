local M = {}

-- Filetypes biome doesn't support
M.biome_unsupported = {
  scss = true,
  markdown = true,
  yaml = true,
}

-- Detect which web formatter to use per buffer
-- Priority: oxfmt config → prettier config → biome config → oxfmt fallback
M.web_formatter = function(bufnr)
  local root = vim.fn.getcwd()

  -- oxfmt config present?
  if #vim.fs.find({ '.oxfmt.toml', 'oxfmt.toml' }, { path = root }) > 0 then
    return { 'oxfmt' }
  end

  -- prettier config present?
  local prettier_configs = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettierrc.mjs',
    '.prettierrc.toml',
    'prettier.config.js',
    'prettier.config.cjs',
    'prettier.config.mjs',
  }
  if #vim.fs.find(prettier_configs, { path = root }) > 0 then
    return { 'prettierd', 'prettier', stop_after_first = true }
  end

  -- biome config present? (skip for unsupported filetypes)
  local ft = vim.bo[bufnr].filetype
  if not M.biome_unsupported[ft] then
    if #vim.fs.find({ 'biome.json', 'biome.jsonc' }, { path = root }) > 0 then
      return { 'biome' }
    end
  end

  -- fallback: oxfmt
  return { 'oxfmt' }
end

return M
