--[[
File: init.lua
Purpose: 入口檔（已脫離 NvChad，自有 options/mappings/autocmds/plugins）
--]]

-- =============================================================
-- 1. 全域旗標（必須在 lazy.nvim 載入前設定 leader）
-- =============================================================
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- =============================================================
-- 2. 編輯器選項與 autocommand（不依賴插件，先載入）
-- =============================================================
require("options")
require("autocmds")

-- =============================================================
-- 3. lazy.nvim bootstrap
-- =============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

-- =============================================================
-- 4. 按鍵映射（延遲到插件載入後執行，讓 telescope/nvim-tree 指令存在）
-- =============================================================
vim.schedule(function()
  require("mappings")
end)
