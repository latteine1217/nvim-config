--[[
Module: lualine
Purpose: 取代 NvChad 的 statusline (stl)
Dependencies: lualine.nvim, nvim-web-devicons
--]]

local ok, lualine = pcall(require, "lualine")
if not ok then
  vim.notify("lualine 載入失敗", vim.log.levels.ERROR)
  return
end

lualine.setup({
  options = {
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = { left = "│", right = "│" },
    section_separators   = { left = "", right = "" },
    globalstatus = true,
    disabled_filetypes = {
      statusline = { "dashboard", "snacks_dashboard", "alpha", "starter" },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", { "diff", symbols = { added = " ", modified = " ", removed = " " } } },
    lualine_c = {
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
      { "filename", path = 1, symbols = { modified = "● ", readonly = " " } },
    },
    lualine_x = {
      function()
        local recording_register = vim.fn.reg_recording()
        if recording_register ~= "" then return "recording @" .. recording_register end
        return ""
      end,
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree", "trouble", "toggleterm", "mason", "lazy" },
})
