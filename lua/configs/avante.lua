--[[
Module: avante
Purpose: Cursor 風格 AI sidebar（diff-first workflow）
Dependencies: avante.nvim, plenary, nui, copilot.lua, web-devicons
Usage: 由 plugins/init.lua 於 VeryLazy 載入

設計：
- provider = "copilot"，沿用既有 Copilot 認證（與 CodeCompanion 共用）
- 預設 model claude-sonnet-4；可在 chat 內用 :AvanteModels 切換
- 與 CodeCompanion 共存：avante 著重 sidebar diff、CodeCompanion 著重 chat / actions
--]]

local ok, avante = pcall(require, "avante")
if not ok then
  vim.notify("avante.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

avante.setup({
  provider = "copilot",

  providers = {
    copilot = {
      model = "claude-sonnet-4", -- Copilot 已開放的 Anthropic 模型
      timeout = 30000,
      extra_request_body = {
        temperature = 0,
        max_tokens = 8192,
      },
    },
  },

  -- 行為控制
  behaviour = {
    auto_suggestions = false, -- 避免與 copilot.lua ghost-text 衝突
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = true,
    minimize_diff = true, -- 只顯示最小 diff
    enable_token_counting = true,
  },

  -- UI 視窗
  windows = {
    position = "right",
    width = 35, -- 百分比
    sidebar_header = {
      align = "center",
      rounded = true,
    },
    input = {
      prefix = "> ",
      height = 8,
    },
    edit = {
      border = "rounded",
      start_insert = true,
    },
    ask = {
      floating = false,
      start_insert = true,
      border = "rounded",
      focus_on_apply = "ours",
    },
  },

  -- diff 行為
  diff = {
    autojump = true,
    list_opener = "copen",
  },

  -- hints
  hints = { enabled = true },

  -- 檔案選擇器（與既有 telescope 整合）
  selector = {
    provider = "telescope",
  },

  -- 提示 prefix
  mappings = {
    diff = {
      ours    = "co",
      theirs  = "ct",
      all_theirs = "ca",
      both    = "cb",
      cursor  = "cc",
      next    = "]x",
      prev    = "[x",
    },
    -- avante 的 inline suggestion 已關閉（auto_suggestions=false），
    -- 這些鍵實際上不會觸發；保留欄位但用 Mac 友善的值，避免之後啟用時撞到
    suggestion = {
      accept  = "<C-y>",
      next    = false,
      prev    = false,
      dismiss = "<C-]>",
    },
    jump   = { next = "]]", prev = "[[" },
    submit = { normal = "<CR>", insert = "<C-s>" },
    sidebar = {
      apply_all      = "A",
      apply_cursor   = "a",
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
    },
  },
})

-- 補充快捷鍵（avante 自動 set_keymaps 已有大半，這邊補命名空間 <leader>A*）
local map = vim.keymap.set
map({ "n", "v" }, "<leader>Aa", "<cmd>AvanteAsk<cr>",     { desc = "Avante: Ask" })
map({ "n", "v" }, "<leader>Ae", "<cmd>AvanteEdit<cr>",    { desc = "Avante: Edit" })
map("n",          "<leader>At", "<cmd>AvanteToggle<cr>",  { desc = "Avante: Toggle Sidebar" })
map("n",          "<leader>Ar", "<cmd>AvanteRefresh<cr>", { desc = "Avante: Refresh" })
map("n",          "<leader>Am", "<cmd>AvanteModels<cr>",  { desc = "Avante: Switch Model" })
