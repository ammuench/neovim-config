local M = {}

-- Add cache to prevent re-running on every cache command.
-- Once per project should be good enough
M._cache = {}

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

  if M._cache[root] then
    return M._cache[root]
  end

  local result

  -- oxfmt config present?
  if #vim.fs.find({ '.oxfmt.toml', 'oxfmt.toml' }, { path = root }) > 0 then
    result = { 'oxfmt' }
  -- prettier config present?
  elseif #vim.fs.find({
    '.prettierrc', '.prettierrc.json', '.prettierrc.yml', '.prettierrc.yaml',
    '.prettierrc.json5', '.prettierrc.js', '.prettierrc.cjs', '.prettierrc.mjs',
    '.prettierrc.toml', 'prettier.config.js', 'prettier.config.cjs', 'prettier.config.mjs',
  }, { path = root }) > 0 then
    result = { 'prettierd', 'prettier', stop_after_first = true }
  -- biome config present? (skip for unsupported filetypes)
  elseif not M.biome_unsupported[vim.bo[bufnr].filetype]
    and #vim.fs.find({ 'biome.json', 'biome.jsonc' }, { path = root }) > 0 then
    result = { 'biome' }
  else
    -- fallback: oxfmt
    result = { 'oxfmt' }
  end

  M._cache[root] = result
  return result
end

return M
