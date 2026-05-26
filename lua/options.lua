--[[
Module: options
Purpose: 編輯器選項（已脫離 NvChad，所有預設明示設定）
Usage: 由 init.lua 載入
--]]

local opt = vim.opt
local g   = vim.g

-- =============================================================
-- 顯示
-- =============================================================
opt.number         = true
opt.relativenumber = true
opt.wrap           = false
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.cursorline     = true
opt.signcolumn     = "yes"
opt.cmdheight      = 1
opt.showmode       = false      -- mode 由 lualine 顯示
opt.laststatus     = 3          -- 單一 global statusline（與 lualine globalstatus 對齊）
opt.termguicolors  = true
opt.background     = "dark"
opt.pumheight      = 10
opt.fillchars:append({ eob = " " })

-- =============================================================
-- 縮排
-- =============================================================
opt.expandtab    = true
opt.shiftwidth   = 2
opt.tabstop      = 2
opt.softtabstop  = 2
opt.smartindent  = true

-- =============================================================
-- 搜尋
-- =============================================================
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = true
opt.incsearch  = true

-- =============================================================
-- Buffer / Window 行為
-- =============================================================
opt.splitright = true
opt.splitbelow = true
opt.mouse      = "a"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("sIcCFW")

-- =============================================================
-- 剪貼板與檔案
-- =============================================================
opt.clipboard   = "unnamedplus"
opt.backup      = false
opt.writebackup = false
opt.swapfile    = false
opt.undofile    = true
opt.undolevels  = 10000
opt.confirm     = true

-- =============================================================
-- 效能
-- =============================================================
opt.updatetime = 300
opt.timeoutlen = 500
opt.redrawtime = 1500
opt.synmaxcol  = 240
opt.lazyredraw = false  -- 與 noice / blink.cmp 動畫相容

-- =============================================================
-- Folding（與 nvim-ufo 對齊）
-- =============================================================
opt.foldcolumn     = "1"
opt.foldlevel      = 99
opt.foldlevelstart = 99
opt.foldenable     = true

-- =============================================================
-- 全域旗標
-- =============================================================
g.mapleader      = " "
g.maplocalleader = " "
g.have_nerd_font = true

-- 關閉內建插件（用不到，避免影響 oil/nvim-tree）
g.loaded_netrw       = 1
g.loaded_netrwPlugin = 1
