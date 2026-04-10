local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- UI
opt.signcolumn = 'yes'
opt.wrap = false
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 8
opt.foldlevel = 99

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- System
opt.clipboard = 'unnamedplus'
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
