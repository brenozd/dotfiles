vim.g.autochdir = true
vim.opt.list = true
vim.opt.clipboard = "unnamedplus"
vim.g.textwidth = 160
vim.opt.wrap = true
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.nu = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 9999
vim.opt.updatetime = 50

