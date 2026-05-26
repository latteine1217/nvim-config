--[[
Module: snacks
Purpose: folke/snacks.nvim QoL 集合，僅啟用與既有設定不衝突的模組
Dependencies: snacks.nvim
Usage: 由 plugins/init.lua 在啟動階段載入（priority=1000）

設計取捨：
- 不啟用 notifier：noice + nvim-notify 已接管通知
- 不啟用 indent：NvChad 已內建 indent-blankline
- 不啟用 dashboard：NvChad 已有 nvdash
- 不啟用 lazygit / terminal：toggleterm 已綁 <leader>gg / <C-\>
- 不啟用 picker / explorer：避免與 NvChad 的 telescope / nvim-tree 衝突
--]]

local ok, snacks = pcall(require, "snacks")
if not ok then
  vim.notify("snacks.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

snacks.setup({
  -- 大檔效能保護：自動關閉昂貴功能（treesitter highlight、syntax 等）
  bigfile = {
    enabled = true,
    notify = true,
    size = 1.5 * 1024 * 1024, -- > 1.5MB 視為大檔
  },

  -- 加速大檔開啟（在 syntax/filetype 觸發前就把 buffer 顯示出來）
  quickfile = { enabled = true },

  -- 智慧 scope 偵測（縮排區塊邊界，可用於 [i / ]i / textobject）
  scope = {
    enabled = true,
    keys = {
      textobject = {
        ii = { min_size = 2, edge = false, cursor = false, desc = "inner scope" },
        ai = { min_size = 2, cursor = false, desc = "around scope" },
      },
      jump = {
        ["[i"] = { min_size = 1, bottom = false, desc = "jump to top edge of scope" },
        ["]i"] = { min_size = 1, bottom = true,  desc = "jump to bottom edge of scope" },
      },
    },
  },

  -- Scratch buffer（暫存草稿，依 cwd/filetype 自動分類）
  scratch = { enabled = true },

  -- Git 整合：用瀏覽器開啟當前檔案在 GitHub/GitLab 的位置
  gitbrowse = { enabled = true },

  -- 關閉預設不需要的（顯式列出方便日後啟用）
  notifier   = { enabled = false },
  indent     = { enabled = false },
  dashboard  = { enabled = false },
  lazygit    = { enabled = false },
  terminal   = { enabled = false },
  picker     = { enabled = false },
  explorer   = { enabled = false },
  statuscolumn = { enabled = false },
})

-- 快捷鍵
local map = vim.keymap.set

map("n", "<leader>.",  function() snacks.scratch() end,           { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S",  function() snacks.scratch.select() end,    { desc = "Select Scratch Buffer" })
map("n", "<leader>gB", function() snacks.gitbrowse() end,         { desc = "Git Browse (open in browser)" })
map("v", "<leader>gB", function() snacks.gitbrowse() end,         { desc = "Git Browse selection" })
