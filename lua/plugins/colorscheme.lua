--[[
Module: plugins.colorscheme
Purpose: 主題 override。catppuccin 已隨 LazyVim 內建，這裡切換 colorscheme 並設 flavour。
--]]

return {
  -- catppuccin flavour：latte(亮) / frappe / macchiato / mocha(暗，預設)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "mocha" },
  },

  -- 讓 LazyVim 啟動時套用 catppuccin
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin" },
  },
}
