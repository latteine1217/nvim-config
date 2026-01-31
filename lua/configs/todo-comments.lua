--[[
Module: todo-comments
Purpose: TODO/FIXME/NOTE 等關鍵字高亮與快速導航
Dependencies: todo-comments.nvim, telescope.nvim (可選)
Usage: 由 plugins/init.lua 自動載入
--]]

local ok, todo = pcall(require, "todo-comments")
if not ok then
  vim.notify("todo-comments.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

todo.setup({
  signs = true, -- 在 sign column 顯示圖示
  sign_priority = 8,

  -- 關鍵字配置
  keywords = {
    FIX = {
      icon = " ", -- 圖示
      color = "error", -- 紅色
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- 別名
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },

  -- 合併連續的關鍵字行
  merge_keywords = true,

  -- 高亮設定
  highlight = {
    multiline = true, -- 支援多行
    multiline_pattern = "^.", -- 多行模式
    multiline_context = 10, -- 多行上下文行數
    before = "", -- 關鍵字前高亮
    keyword = "wide", -- 高亮整個關鍵字（wide/fg/bg）
    after = "fg", -- 關鍵字後文字使用前景色
    pattern = [[.*<(KEYWORDS)\s*:]], -- 匹配模式
    comments_only = true, -- 僅在註解中高亮
    max_line_len = 400, -- 最大行長度
    exclude = {}, -- 排除的檔案類型
  },

  -- 搜尋配置
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    pattern = [[\b(KEYWORDS):]], -- ripgrep 模式
  },
})

-- 快捷鍵：使用 Telescope 搜尋 TODO
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
