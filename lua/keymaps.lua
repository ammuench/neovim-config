-- lua/keymaps.lua

local map = vim.keymap.set

-- Save / Quit
map("n", "<Leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("n", "<Leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<Leader>n", "<cmd>enew<cr>", { desc = "New file" })

-- Navigation (half-page + center)
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down + center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up + center" })

-- Splits
map("n", "<Leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<Leader>-", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Split navigation (native — swap for smart-splits or zellij-nav later)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Visual mode indenting (keep selection after indent)
map("v", "<Tab>", ">gv", { desc = "Indent" })
map("v", "<S-Tab>", "<gv", { desc = "Outdent" })

-- Comments
map("n", "<Leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<Leader>/", "gc", { desc = "Toggle comment", remap = true })

-- UI toggles
map("n", "<Leader>uw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  vim.opt.linebreak = vim.opt.wrap:get()
end, { desc = "Toggle wrap (break on word)" })
map("n", "<Leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
map("n", "<Leader>uh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
map("n", "<Leader>un", "<cmd>set number! relativenumber!<cr>", { desc = "Toggle line numbers" })

-- LSP Info
map("n", "<Leader>lI", "<cmd>checkhealth vim.lsp<cr>", { desc = "See attached LSPs for buffer" })
