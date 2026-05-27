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

-- nvim-surround v4 已不再透過 setup() 設 keymaps；下列預設鍵位由插件自帶：
--   Insert       <C-g>s / <C-g>S
--   Normal       ys{motion}{char}  /  yss{char}  /  yS  /  ySS
--   Visual       S{char}  /  gS
--   Delete       ds{char}
--   Change       cs{old}{new}  /  cS
-- 如要改變鍵位，使用 vim.keymap.set 對應 <Plug>(nvim-surround-*)

surround.setup({
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
