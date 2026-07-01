--[[
Module: plugins.colorscheme
Purpose: 主題 override。catppuccin 已隨 LazyVim 內建。
Note: 直接指定 flavour 專屬 colorscheme 名稱（catppuccin-<flavour>），
      避免 LazyVim 套色時序早於 flavour opt 生效造成的 race（會誤用預設 mocha）。
      可用值：catppuccin-latte / -frappe / -macchiato / -mocha
--]]

return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-macchiato" },
  },
}
