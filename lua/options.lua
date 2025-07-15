require("nvchad.options")

local opt = vim.opt
local g = vim.g

opt.relativenumber = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

opt.ignorecase = true
opt.smartcase = true

opt.clipboard = "unnamedplus"

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

opt.updatetime = 300
opt.timeoutlen = 500

g.have_nerd_font = true
