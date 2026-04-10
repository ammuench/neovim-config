local map = vim.keymap.set

-- Save / Quit
map('n', '<Leader>w', '<cmd>w<cr>', { desc = 'Save' })
map('n', '<Leader>q', '<cmd>q<cr>', { desc = 'Quit' })
map('n', '<Leader>n', '<cmd>enew<cr>', { desc = 'New file' })

-- Navigation (half-page + center)
map('n', '<C-d>', '<C-d>zz', { desc = 'Half-page down + center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Half-page up + center' })

-- Splits
map('n', '<Leader>|', '<cmd>vsplit<cr>', { desc = 'Vertical split' })
map('n', '<Leader>-', '<cmd>split<cr>', { desc = 'Horizontal split' })

-- Split navigation (native — swap for smart-splits or zellij-nav later)
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to below split' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to above split' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- Buffer management (requires snacks.nvim — wired in Phase 1)
-- map('n', '<Leader>c', function() Snacks.bufdelete() end, { desc = 'Close buffer' })
-- map('n', '<Leader>C', function() Snacks.bufdelete({ force = true }) end, { desc = 'Force close buffer' })

-- Snacks.picker (wired in Phase 1)
-- map('n', '<Leader>ff', function() Snacks.picker.files() end, { desc = 'Find files' })
-- map('n', '<Leader>fw', function() Snacks.picker.grep() end, { desc = 'Live grep' })
-- map('n', '<Leader>fb', function() Snacks.picker.buffers() end, { desc = 'Find buffers' })
-- map('n', '<Leader>fo', function() Snacks.picker.recent() end, { desc = 'Find recent files' })

-- LSP (wired in Phase 2 on_attach)
-- map('n', '<Leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
-- map('n', '<Leader>lR', vim.lsp.buf.references, { desc = 'Show all references' })
-- map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover docs' })
-- map('n', '<Leader>la', vim.lsp.buf.code_action, { desc = 'Code actions' })
-- map('n', '<Leader>lr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
-- map('n', 'gl', vim.diagnostic.open_float, { desc = 'Hover diagnostics' })
-- map('n', '<Leader>R', '<cmd>LspRestart<cr>', { desc = 'LSP Restart' })

-- Formatting (wired in Phase 4)
-- map('n', '<Leader>F', function() require('conform').format({ async = true }) end, { desc = 'Format buffer' })

-- Linter fix-all (wired in Phase 4 — conditional per repo)
-- map('n', '<Leader>L', '<cmd>EslintFixAll<cr>', { desc = 'ESLint Fix All' })
-- map('n', '<Leader>B', '<cmd>BiomeCheckCurrentFile<cr>', { desc = 'Biome Check' })
-- map('n', '<Leader>O', '<cmd>LspOxlintFixAll<cr>', { desc = 'Oxlint Fix All' })

-- Git (wired in Phase 1 with gitsigns + snacks.picker)
-- map('n', '<Leader>gl', function() Snacks.git.blame_line() end, { desc = 'Git blame line' })
-- map('n', '<Leader>gc', function() Snacks.picker.git_log() end, { desc = 'Git commits (all)' })
-- map('n', '<Leader>gC', function() Snacks.picker.git_log({ current_file = true }) end, { desc = 'Git commits (file)' })
-- map('n', '<Leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })

-- Plugin toggles (wired in Phase 1)
-- map('n', '<Leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle neo-tree' })
-- map('n', '<Leader>tf', '<cmd>ToggleTerm<cr>', { desc = 'Toggle terminal' })
-- map('n', '<Leader>/', 'gcc', { desc = 'Toggle comment', remap = true })

-- UI toggles
-- map('n', '<Leader>uw', '<cmd>set wrap!<cr>', { desc = 'Toggle wrap' })
-- map('n', '<Leader>ud', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = 'Toggle diagnostics' })
-- map('n', '<Leader>uh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = 'Toggle inlay hints' })
-- map('n', '<Leader>un', '<cmd>set number! relativenumber!<cr>', { desc = 'Toggle line numbers' })
-- map('n', '<Leader>ui', -- TODO: depends on indent guide plugin choice, { desc = 'Toggle indent guides' })
