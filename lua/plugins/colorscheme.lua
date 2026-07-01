--[[
Module: plugins.colorscheme
Purpose: 主題 override。改用 onedark（NvChad 招牌調性：近黑中性深底、非藍紫冷調）。
Note: style 可選 dark / darker / deep / cool / warm / warmer；darker≈NvChad 預設底色。
--]]

return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "darker", -- 近似 NvChad onedark 的 #1e222a 深底
      transparent = false,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "onedark" },
  },
}
