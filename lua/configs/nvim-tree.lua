--[[
Module: nvim-tree
Purpose: 接管 NvChad 的 nvim-tree 設定
Dependencies: nvim-tree.lua, nvim-web-devicons
--]]

local ok, tree = pcall(require, "nvim-tree")
if not ok then
  vim.notify("nvim-tree 載入失敗", vim.log.levels.ERROR)
  return
end

tree.setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = { enable = true, update_root = false },

  view = {
    width = 32,
    side = "left",
    preserve_window_proportions = true,
  },

  renderer = {
    root_folder_label = false,
    indent_markers = { enable = true },
    icons = {
      git_placement = "after",
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open   = "",
        },
        git = {
          unstaged  = "",
          staged    = "",
          unmerged  = "",
          renamed   = "",
          untracked = "",
          deleted   = "",
          ignored   = "",
        },
      },
    },
  },

  diagnostics = { enable = true, show_on_dirs = true },
  filters     = { dotfiles = false, custom = { "^.git$" } },
  git         = { enable = true, ignore = false },
  actions     = { open_file = { quit_on_open = false } },
})
