vim.g.autochdir = true
vim.opt.list = true
vim.g.clipboard = "unammedplus"
vim.g.textwidth = 256
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 9999
vim.opt.updatetime = 50
