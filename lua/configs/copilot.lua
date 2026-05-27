--[[
Module: copilot
Purpose: GitHub Copilot AI 代碼補全配置
Dependencies: copilot.lua
Usage: 由 plugins/init.lua 在 InsertEnter 事件載入
--]]

local ok, copilot = pcall(require, "copilot")
if not ok then
  vim.notify("copilot.lua 載入失敗", vim.log.levels.ERROR)
  return
end

copilot.setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      -- Mac 終端機 Option 預設不送 Meta，原 <M-CR> 改為 <C-CR>（多數現代 terminal 支援）
      -- 或從 normal mode 用 :Copilot panel / <leader>cp
      open = "<C-CR>",
    },
    layout = {
      position = "bottom", -- 建議面板位置: top, bottom, left, right
      ratio = 0.4,
    },
  },

  suggestion = {
    enabled = true,
    auto_trigger = true, -- 自動觸發建議
    hide_during_completion = true, -- 在補全選單開啟時隱藏
    debounce = 75, -- 延遲時間（ms）
    keymap = {
      -- Mac 友善：避開所有 <M-*>（Option 不送 Meta）
      accept      = "<C-y>",     -- Ctrl+y 接受整段（LazyVim 慣例）
      accept_word = "<C-Right>", -- Ctrl+→ 只接受下一個 word
      accept_line = false,
      next        = false,        -- 多數情況用不到、又難綁；如需打開 <leader>cp 面板瀏覽
      prev        = false,
      dismiss     = "<C-]>",     -- Ctrl+] 關閉當前建議（Mac 可直接打）
    },
  },

  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },

  copilot_node_command = "node", -- Node.js 執行檔路徑
  server_opts_overrides = {},
})

-- 顯示 Copilot 狀態
vim.api.nvim_create_user_command("CopilotStatus", function()
  local status = require("copilot.api").status.data.status
  local message = status == "Normal" and "Copilot: ✅ 已啟用" or "Copilot: ❌ " .. status
  vim.notify(message, vim.log.levels.INFO)
end, {})

-- Normal mode：開啟 Copilot 面板（取代原 Alt+Enter）
vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<cr>", { desc = "Copilot panel" })
