--[[
Module: flash
Purpose: 超快速跳轉（取代傳統 f/t/search）
Dependencies: flash.nvim
Usage: 由 plugins/init.lua 按需載入
--]]

local ok, flash = pcall(require, "flash")
if not ok then
  vim.notify("flash.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

flash.setup({
  labels = "asdfghjklqwertyuiopzxcvbnm", -- 跳轉標籤字元
  search = {
    mode = "exact", -- 精確搜尋
    incremental = false, -- 非增量搜尋
    multi_window = true, -- 跨窗口跳轉
    forward = true,
    wrap = true,
  },
  jump = {
    jumplist = true, -- 加入跳轉列表（Ctrl+o 返回）
    pos = "start", -- 跳轉到匹配開始位置
    history = false,
    register = false,
    nohlsearch = false,
    autojump = false, -- 單一匹配時不自動跳轉
  },
  label = {
    uppercase = false, -- 不使用大寫標籤（避免按 Shift）
    rainbow = {
      enabled = false, -- 不使用彩虹色（保持簡潔）
      shade = 5,
    },
  },
  modes = {
    search = {
      enabled = true, -- 增強 / 搜尋
    },
    char = {
      enabled = true, -- 增強 f/t/F/T
      jump_labels = true, -- 多匹配時顯示標籤
      multi_line = true, -- 跨行跳轉
    },
  },
})
