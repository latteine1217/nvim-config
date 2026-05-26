--[[
Module: catppuccin
Purpose: 主題（取代 NvChad base46），mocha flavor 對應 NvChad 預設的 catppuccin
Dependencies: catppuccin/nvim
--]]

local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  vim.notify("catppuccin 載入失敗", vim.log.levels.ERROR)
  return
end

catppuccin.setup({
  flavour = "mocha", -- latte / frappe / macchiato / mocha
  background = { light = "latte", dark = "mocha" },
  transparent_background = false,
  show_end_of_buffer = false,
  term_colors = true,

  styles = {
    comments     = { "italic" },
    conditionals = { "italic" },
    loops        = {},
    functions    = {},
    keywords     = {},
    strings      = {},
    variables    = {},
    numbers      = {},
    booleans     = {},
    properties   = {},
    types        = {},
    operators    = {},
  },

  integrations = {
    blink_cmp        = true,
    cmp              = false,
    gitsigns         = true,
    nvimtree         = true,
    treesitter       = true,
    notify           = true,
    mini             = { enabled = true, indentscope_color = "" },
    mason            = true,
    which_key        = true,
    telescope        = { enabled = true },
    bufferline       = true,
    lsp_trouble      = true,
    indent_blankline = { enabled = true },
    flash           = true,
    snacks          = { enabled = true },
    illuminate      = { enabled = false },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors      = { "italic" },
        hints       = { "italic" },
        warnings    = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors      = { "underline" },
        hints       = { "underline" },
        warnings    = { "underline" },
        information = { "underline" },
      },
    },
  },
})

vim.cmd.colorscheme("catppuccin")
