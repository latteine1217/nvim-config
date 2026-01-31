--[[
Module: surround
Purpose: 快速操作括號、引號、HTML 標籤等包圍字元
Dependencies: nvim-surround
Usage: 由 plugins/init.lua 自動載入
--]]

local ok, surround = pcall(require, "nvim-surround")
if not ok then
  vim.notify("nvim-surround 載入失敗", vim.log.levels.ERROR)
  return
end

surround.setup({
  keymaps = {
    insert = "<C-g>s", -- Insert 模式：Ctrl+g s
    insert_line = "<C-g>S",
    normal = "ys", -- Normal 模式：ys{motion}{char}
    normal_cur = "yss", -- 當前行：yss{char}
    normal_line = "yS",
    normal_cur_line = "ySS",
    visual = "S", -- Visual 模式：S{char}
    visual_line = "gS",
    delete = "ds", -- 刪除：ds{char}
    change = "cs", -- 替換：cs{old}{new}
    change_line = "cS",
  },

  -- 常用包圍字元別名
  aliases = {
    ["a"] = ">", -- a = angle brackets <>
    ["b"] = ")", -- b = brackets ()
    ["B"] = "}", -- B = Braces {}
    ["r"] = "]", -- r = square brackets []
    ["q"] = { '"', "'", "`" }, -- q = quotes
  },

  -- 高亮配置
  highlight = {
    duration = 0, -- 不顯示高亮（保持簡潔）
  },

  move_cursor = "begin", -- 操作後游標移至開始位置
})
