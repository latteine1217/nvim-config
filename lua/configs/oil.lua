--[[
Module: oil
Purpose: buffer-style 目錄編輯，補強 nvim-tree（後者偏側欄樹狀，oil 偏行內快速編輯）
Dependencies: oil.nvim, nvim-web-devicons
Usage: 由 plugins/init.lua 載入；按 - 開啟父目錄的 oil buffer
--]]

local ok, oil = pcall(require, "oil")
if not ok then
  vim.notify("oil.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

oil.setup({
  -- 預設關閉 netrw（避免與 oil 衝突）
  default_file_explorer = false, -- 保留 nvim-tree 為主，oil 為輔

  -- 視圖選項
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },

  -- 編輯緩衝區行為
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },

  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },

  -- 刪除檔案進垃圾桶而非永久刪除（safer）
  delete_to_trash = true,
  skip_confirm_for_simple_edits = false,
  prompt_save_on_select_new_entry = true,

  -- 鍵位（保留多數 vim 直覺操作）
  use_default_keymaps = true,
  keymaps = {
    ["g?"]    = { "actions.show_help", mode = "n" },
    ["<CR>"]  = "actions.select",
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["<C-l>"] = "actions.refresh",
    ["-"]     = { "actions.parent", mode = "n" },
    ["_"]     = { "actions.open_cwd", mode = "n" },
    ["`"]     = { "actions.cd", mode = "n" },
    ["~"]     = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"]    = { "actions.change_sort", mode = "n" },
    ["gx"]    = "actions.open_external",
    ["g."]    = { "actions.toggle_hidden", mode = "n" },
    ["g\\"]   = { "actions.toggle_trash", mode = "n" },
  },

  view_options = {
    show_hidden = false,
    is_hidden_file = function(name)
      return vim.startswith(name, ".")
    end,
    is_always_hidden = function(name)
      return name == ".." or name == ".git"
    end,
    natural_order = true,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
  },

  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = { winblend = 0 },
  },
})

-- 快捷鍵
local map = vim.keymap.set
map("n", "-",          "<cmd>Oil<cr>",        { desc = "Oil: open parent directory" })
map("n", "<leader>fo", "<cmd>Oil --float<cr>", { desc = "Oil: floating file explorer" })
