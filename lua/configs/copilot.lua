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
      open = "<M-CR>", -- Alt+Enter 開啟建議面板
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
      accept = "<M-l>", -- Alt+l 接受建議（避免與 Tab 衝突）
      accept_word = false,
      accept_line = false,
      next = "<M-]>", -- Alt+] 下一個建議
      prev = "<M-[>", -- Alt+[ 上一個建議
      dismiss = "<C-]>", -- Ctrl+] 關閉建議
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
