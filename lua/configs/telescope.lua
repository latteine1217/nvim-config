--[[
Module: telescope
Purpose: 接管 NvChad 的 telescope 設定
Dependencies: telescope.nvim, telescope-fzf-native
--]]

local ok, telescope = pcall(require, "telescope")
if not ok then
  vim.notify("telescope 載入失敗", vim.log.levels.ERROR)
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
      vertical   = { mirror = false },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/", "__pycache__" },
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
      n = { q = actions.close },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

pcall(telescope.load_extension, "fzf")
