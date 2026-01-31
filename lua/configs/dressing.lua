--[[
Module: dressing
Purpose: 美化 vim.ui.select 和 vim.ui.input 介面
Dependencies: dressing.nvim, telescope.nvim (可選)
Usage: 由 plugins/init.lua 自動載入
--]]

local ok, dressing = pcall(require, "dressing")
if not ok then
  vim.notify("dressing.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

dressing.setup({
  input = {
    enabled = true,
    default_prompt = "Input:", -- 預設提示
    trim_prompt = true, -- 移除提示前後空白
    title_pos = "left", -- 標題位置: left, center, right
    insert_only = true, -- 僅在插入模式啟動
    start_in_insert = true,

    -- 浮動窗口配置
    border = "rounded",
    relative = "cursor", -- 相對於游標
    prefer_width = 40,
    width = nil,
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },

    win_options = {
      winblend = 10, -- 透明度
      wrap = false,
      list = true,
      listchars = "precedes:…,extends:…",
      sidescrolloff = 0,
    },

    mappings = {
      n = {
        ["<Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
        ["<Up>"] = "HistoryPrev",
        ["<Down>"] = "HistoryNext",
      },
    },
  },

  select = {
    enabled = true,
    backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" }, -- 優先順序

    -- Telescope 配置
    telescope = require("telescope.themes").get_dropdown({
      layout_config = {
        width = 0.8,
        height = 0.6,
      },
    }),

    -- 內建 vim.ui.select 配置
    builtin = {
      border = "rounded",
      relative = "editor",
      win_options = {
        winblend = 10,
      },
      width = nil,
      max_width = { 140, 0.8 },
      min_width = { 40, 0.2 },
      height = nil,
      max_height = 0.9,
      min_height = { 10, 0.2 },
    },

    -- 格式化函式（根據不同用途調整顯示）
    format_item_override = {},
  },
})
